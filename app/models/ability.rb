class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action(:read, :create, :update, to: :access_but_not_delete)
    alias_action(:_vote_reset_thumbs, :_vote_for_thumbs, :_vote_against_thumbs, :to => :vote)
    # alias_action(:read, :palabra, :tra_palabra, :search, :check_text, :my_profile, :glosario, :to => :do_frontend_stuff)
    # alias_action(:index, :play, :check, :session_results, to: :can_play_spelling)

    can :read, [Word, Glossary] # permissions for every user, even if not logged in
    can :autocomplete_word_name, Word
    can :game,                   Memory

    if user.present?
      if user.role? :superadmin
        can :manage, :all
      elsif user.role? :admin
        can :read,                   [Word, Source, Wordtype, Goal, Role, FshpCategory,
                                      Picture, Recording, Glossary, SpellingGroup]
        can :create,                 [Word, Source, Wordtype, Goal, Picture, Recording, Glossary, SpellingGroup]
        can :update,                 [Word, Source, Picture, Recording, Glossary, SpellingGroup]
        can [:soft_delete, :soft_restore, :vote], Word
        # can :do_frontend_stuff,      :frontends
        can :rapport,                FrontendsController
        can :my_profile,             FrontendsController
        can :read,                   User, id: user.id   # for self
        can :update,                 User, [:new_words, :own_words, :most_voted, :password], id: user.id   # for self
        can :read,                   User, [:name, :email,:roles]  # for other users
        # can :can_play_spelling,      :spellings
        cannot :update,              Word, [:buki_di_oro, :buki_di_oro_text, :sources]
        # cannot :update,              User, Role
      elsif user.role? :viewer
        can :read,                   [Word, Source, Wordtype, Goal, Role, FshpCategory,
                                      Picture, Recording, SpellingGroup]
        can [:create, :vote],         Word
        can :update,                  Word, :views
        can :manage,                 Glossary, id: user.id # for managing own glossaries
        can :read,                   User, id: user.id   # for self
        can :update,                 User, [:new_words, :own_words, :most_voted, :password], id: user.id   # for self
        can :my_profile,             FrontendsController
      end
    end
  end
end
# elsif user.role? :worker
#   can :read,                    [Word, :sources, :wordtypes, :goals,:roles,:fshp_categories,
#                                  :pictures, :recordings]
#   can [:create, :vote],         Word
#   can :update,                  Word, user_id: user.id
#   can :update,                  Word, [:attested, :attested_on]
#   can :update,                  Word, :views
#   can :do_frontend_stuff,       :frontends
#   can :read,                    :users, [:name, :email, :roles]
#   can :access_but_not_delete,   :users, id: user.id
#   can :can_play_spelling,      :spellings
#   cannot :update,               Word, [:buki_di_oro, :buki_di_oro_text]
#   cannot :update,               :users, :roles
# elsif user.role? :viewer

#   can :can_play_spelling,      :spellings
#   elsif user.id.nil?
#     can :read,                    [Word, :sources, :wordtypes, :goals,:roles,:fshp_categories,
#                                    :pictures, :recordings]
#     can :do_frontend_stuff,       :frontends
#     #can :can_play_spelling,      :spellings
