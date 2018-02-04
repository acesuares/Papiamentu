class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action(:read, :create, :update, to: :access_but_not_delete)
    alias_action(:_vote_reset_thumbs, :_vote_for_thumbs, :_vote_against_thumbs, :to => :vote)
    alias_action(:read, :palabra, :tra_palabra, :search, :check_text, :my_profile, to: :do_frontend_stuff)

    user ||= User.new # guest user

    # roles
    if user.role?(:superadmin)
      can :manage, :all
    elsif user.role? :admin
      can :access_but_not_delete,  [Word, Source, Wordtype, Goal, Role, FshpCategory]
      can [:destroy, :revert],     Word
      can :do_frontend_stuff,      :frontend
      can :rapport,                :frontend
      can :vote,                   Word
      can :access_but_not_delete,  User, id: user.id
      can :read,                   User#, [:name, :email, :roles]
      #cannot :update,             Word #, [:buki_di_oro, :buki_di_oro_text]
      #cannot :update,             User #, :roles
    elsif user.role? :worker
      can :read,                    [Word, Source, Wordtype, Goal, Role, FshpCategory]
      can :create,                  Word
      can :update,                  Word, user_id: user.id
      #can :update,                 :words, [:attested, :attested_on]
      #cannot :update,              :words, [:buki_di_oro, :buki_di_oro_text]
      #can :update,                 :words, :views
      can :do_frontend_stuff,       :frontend
      can :vote,                    Word
      can :read,                    User #, [:name, :email, :roles]
      can :access_but_not_delete,   User, id: user.id
      #cannot :update,              :users, :roles
    elsif user.role? :viewer
      can :read,                    [Word, Source, Wordtype, Goal, Role]
      can :update,                  Word#, :views
      can :create,                  Word
      can :do_frontend_stuff,       :frontend
      can :vote,                    Word
      #cannot :update,               User#, [:roles, :email]
      can :access_but_not_delete,   User, id: user.id
    end
  end
end
