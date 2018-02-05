require "cancan/matchers"
require 'rails_helper'

describe Ability do
  subject(:ability){ Ability.new(user) }
  let(:user){ nil }

  context "when is an admin" do
    let(:user){ create(:user, :admin) }

    # Words
    %i[read create update revert vote].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Word.new) }
    end

    # Can read other users :name, :email, :roles
    %i[read].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, User.new) }
    end

    # Admin can access_but_not_delete its own user
    %i[read create update].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, user) }
    end

    # Roles
    %i[read].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Role.new) }
    end

    # Is expected to be able to do frontend stuff
    %i[read palabra tra_palabra search check_text my_profile rapport].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, :frontend) }
    end
  end

  context "when is an worker" do
    let(:user){ create(:user, :worker) }

    # Words
    %i[read create vote].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Word.new) }
    end

    # Worker can access_but_not_delete its own user
    %i[read create update].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, user) }
    end

    # Can read other users :name, :email, :roles
    %i[read].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, User.new) }
    end

    # Can update his own words
    %i[update].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, create(:word, user: user)) }
    end

    # Is expected to be able to do frontend stuff
    %i[read palabra tra_palabra search check_text my_profile].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, :frontend) }
    end
  end

  context "when is a viewer" do
    let(:user){ create(:user) }

    # Words
    %i[read create update vote].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Word.new) }
    end

    # Viewer can access_but_not_delete its own user
    %i[read create update].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, user) }
    end

    # Viewer cannot access nor delete other users
    %i[read create update].each do |action|
      it{ is_expected.not_to be_able_to(action.to_sym, User.new) }
    end

    # Is expected to be able to do frontend stuff
    %i[read palabra tra_palabra search check_text my_profile].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, :frontend) }
    end
  end
end
