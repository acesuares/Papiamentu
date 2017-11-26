require 'rails_helper'

describe User do
  context "Create" do
    it "has the viewer role" do
      user = create(:user)
      expect(user.role?(:viewer)).to eq(true)
    end
  end
end
