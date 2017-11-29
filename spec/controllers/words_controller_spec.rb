require 'rails_helper'

RSpec.describe WordsController do
  describe "GET index" do
    it "assigns @objects even when update=words_list is not sended" do
      get :index
      expect(assigns(:objects)).to eq([])
    end
  end
end
