require 'rails_helper'

RSpec.describe FrontendsController do
  describe "GET rapport" do
    it "Successfully" do
      superadmin = create(:user, :superadmin)
      create(:word, name: 'alfabetisashon', user: superadmin)
      sign_in superadmin
      get :rapport
      expect(response.status).to eq(200)
    end
  end
end
