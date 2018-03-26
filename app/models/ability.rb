class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action(:read, :create, :update, to: :access_but_not_delete)
    alias_action(:_vote_reset_thumbs, :_vote_for_thumbs, :_vote_against_thumbs, :to => :vote)
    alias_action(:read, :palabra, :tra_palabra, :search, :check_text, :my_profile, :glosario, :to => :do_frontend_stuff)
    alias_action(:index, :play, :check, :session_results, to: :can_play_spelling)

    user ||= User.new # guest user

    # roles
    if user.role?(:superadmin)
      can :access, :all
    elsif user.role? :admin
      can :access_but_not_delete,  [:words, :sources, :wordtypes, :goals, :roles, :fshp_categories,
                                    :pictures, :recordings, :glossaries, :spelling_groups]
      can [:revert, :destroy, :vote], :words
      can :do_frontend_stuff,      :frontends
      can :rapport,                :frontends
      can :access_but_not_delete,  :users, id: user.id
      can :read,                   :users, [:name, :email,:roles]
      can :can_play_spelling,      :spellings
      cannot :update,              :words, [:buki_di_oro, :buki_di_oro_text]
      cannot :update,              :users, :roles
    elsif user.role? :worker
      can :read,                    [:words, :sources, :wordtypes, :goals,:roles,:fshp_categories,
                                     :pictures, :recordings]
      can [:create, :vote],         :words
      can :update,                  :words, user_id: user.id
      can :update,                  :words, [:attested, :attested_on]
      can :update,                  :words, :views
      can :do_frontend_stuff,       :frontends
      can :read,                    :users, [:name, :email, :roles]
      can :access_but_not_delete,   :users, id: user.id
      can :can_play_spelling,      :spellings
      cannot :update,               :words, [:buki_di_oro, :buki_di_oro_text]
      cannot :update,               :users, :roles
    elsif user.role? :viewer
      can :read,                    [:words, :sources, :wordtypes, :goals,:roles,:fshp_categories,
                                     :pictures, :recordings]
      can [:create, :vote],         :words
      can :update,                  :words, :views
      can :do_frontend_stuff,       :frontends
      can :can_play_spelling,      :spellings
      can :access_but_not_delete,   :users, id: user.id
      cannot :update,               :users, [:roles, :email]
    end
  end
end
