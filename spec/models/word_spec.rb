require 'rails_helper'

describe Word do
  context "Create" do
    it "requires a name attribute for persistance" do
      word = Word.new
      word.save
      expect(word.persisted?).to eq(false)
    end
  end

  context "Update" do
    let(:word) { create(:word) }
    it "gets standarized" do
      word.standarized!
      expect(word.standarized?).to eq(true)
    end
  end
end
