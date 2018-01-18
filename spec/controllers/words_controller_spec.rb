require 'rails_helper'

RSpec.describe WordsController do
  describe "GET index" do
    it "Successfully" do
      sign_in create(:user, :superadmin)
      get :index
      expect(response.status).to eq(200)
      expect(assigns(:objects)).to eq([])
    end
  end
end
