require 'rails_helper'

RSpec.describe SpellingGameController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #play" do
    it "returns http success" do
      get :play
      expect(response).to have_http_status(:success)
    end
  end

end
