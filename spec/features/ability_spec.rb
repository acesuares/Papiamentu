require "cancan/matchers"
require 'rails_helper'

describe Ability do
  subject(:ability){ Ability.new(user) }
  let(:user){ nil }

  context "when is an admin" do
    let(:user){ create(:user, :admin) }

    # access but not delete :words :sources, :wordtypes, :goals, :roles,:fshp_categories
    %i[read create update].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Word.new) }
      it{ is_expected.to be_able_to(action.to_sym, Source.new) }
      it{ is_expected.to be_able_to(action.to_sym, Wordtype.new) }
      it{ is_expected.to be_able_to(action.to_sym, Goal.new) }
      it{ is_expected.to be_able_to(action.to_sym, Role.new) }
      it{ is_expected.to be_able_to(action.to_sym, FshpCategory.new) }
      it{ is_expected.to be_able_to(action.to_sym, Picture.new) }
      it{ is_expected.to be_able_to(action.to_sym, Recording.new) }
    end

    # Also it is expected to be able to revert destroy, revert and vote words
    %i[revert destroy vote].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Word.new) }
    end

    # Is expected to be able to do frontend stuff
    %i[read palabra tra_palabra search check_text my_profile rapport].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, :frontends) }
    end

    # Admin can access_but_not_delete its own user
    %i[read create update].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, user) }
    end

    # Can read other users :name, :email, :roles
    %i[read].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, User.new, :name) }
      it{ is_expected.to be_able_to(action.to_sym, User.new, :email) }
      it{ is_expected.to be_able_to(action.to_sym, User.new, :roles) }
    end

    # Cannot update :words, [:buki_di_oro, :buki_di_oro_text]
    %i[update].each do |action|
      it{ is_expected.not_to be_able_to(action.to_sym, Word.new, :buki_di_oro) }
      it{ is_expected.not_to be_able_to(action.to_sym, Word.new, :buki_di_oro_text) }
    end

    # Cannot update :users, :roles
    %i[update].each do |action|
      it{ is_expected.not_to be_able_to(action.to_sym, User.new, :roles) }
    end
  end

  context "when is an worker" do
    let(:user){ create(:user, :worker) }

    # can read :words :sources, :wordtypes, :goals, :roles,:fshp_categories
    %i[read].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Word.new) }
      it{ is_expected.to be_able_to(action.to_sym, Source.new) }
      it{ is_expected.to be_able_to(action.to_sym, Wordtype.new) }
      it{ is_expected.to be_able_to(action.to_sym, Goal.new) }
      it{ is_expected.to be_able_to(action.to_sym, Role.new) }
      it{ is_expected.to be_able_to(action.to_sym, FshpCategory.new) }
      it{ is_expected.to be_able_to(action.to_sym, Picture.new) }
      it{ is_expected.to be_able_to(action.to_sym, Recording.new) }
    end

    # Can create :words
    %i[create vote].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Word.new) }
    end

    # Can update his own words
    %i[update].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, create(:word, user: user)) }
    end

    # Worker can update its own user
    %i[read create update].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, user) }
    end

    # Worker can update :words
    %i[update].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Word.new, :attested) }
      it{ is_expected.to be_able_to(action.to_sym, Word.new, :attested_on) }
      it{ is_expected.to be_able_to(action.to_sym, Word.new, :views) }
    end

    # Is expected to be able to do frontend stuff
    %i[read palabra tra_palabra search check_text my_profile].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, :frontends) }
    end

    # Can read other users :name, :email, :roles
    %i[read].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, User.new, :name) }
      it{ is_expected.to be_able_to(action.to_sym, User.new, :email) }
      it{ is_expected.to be_able_to(action.to_sym, User.new, :roles) }
    end

    # access but not delete its own user
    %i[read create update].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, user) }
    end

    # Cannot update :words, [:buki_di_oro, :buki_di_oro_text]
    %i[update].each do |action|
      it{ is_expected.not_to be_able_to(action.to_sym, Word.new, :buki_di_oro) }
      it{ is_expected.not_to be_able_to(action.to_sym, Word.new, :buki_di_oro_text) }
    end

    # Cannot update :users, :roles
    %i[update].each do |action|
      it{ is_expected.not_to be_able_to(action.to_sym, User.new, :roles) }
    end
  end

  context "when is a viewer" do
    let(:user){ create(:user) }

    # can read :words :sources, :wordtypes, :goals, :roles,:fshp_categories
    %i[read].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Word.new) }
      it{ is_expected.to be_able_to(action.to_sym, Source.new) }
      it{ is_expected.to be_able_to(action.to_sym, Wordtype.new) }
      it{ is_expected.to be_able_to(action.to_sym, Goal.new) }
      it{ is_expected.to be_able_to(action.to_sym, Role.new) }
      it{ is_expected.to be_able_to(action.to_sym, FshpCategory.new) }
      it{ is_expected.to be_able_to(action.to_sym, Picture.new) }
      it{ is_expected.to be_able_to(action.to_sym, Recording.new) }      
    end

    # Can create and vote :words
    %i[create vote].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Word.new) }
    end

    # Worker can update :words
    %i[update].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Word.new, :views) }
    end

    # Is expected to be able to do frontend stuff
    %i[read palabra tra_palabra search check_text my_profile].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, :frontends) }
    end

    # access but not delete its own user
    %i[read create update].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, user) }
    end

    # Cannot update :users, :email :roles
    %i[update].each do |action|
      it{ is_expected.not_to be_able_to(action.to_sym, User.new, :email) }
      it{ is_expected.not_to be_able_to(action.to_sym, User.new, :roles) }
    end
  end
end
