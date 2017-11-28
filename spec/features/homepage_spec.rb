require 'rails_helper'

feature 'Homepage' do

  context "Viewers visits homepage" do
    it "Successfully" do
      viewer = create(:user)
      login_as(viewer)

      visit root_path

      expect(page).to have_css 'h2'
      expect(page).to have_content('papiamentu')
      expect(page).to have_content('buska un palabra')
    end
  end

  context "Viewers searches a word" do
    it "Successfully" do
      create(:word, name: 'alfabetisashon')
      viewer = create(:user)
      login_as(viewer)

      visit root_path

      fill_in 'word', with: 'alfabetisashon'
      click_button 'buska'

      expect(page).to have_css 'h2'
      expect(page).to have_content('alfabetisashon')
      expect(page).to have_content('informashon')
      expect(page).to have_content('lingwístiko')
    end
  end

  context "Viewers can logout" do
    it "Successfully" do
      viewer = create(:user)
      login_as(viewer)

      visit root_path

      within(:css, '#right-side') do
        click_link 'finalisá seshon'
      end

      expect(page).to have_content('Bon biní na Papiamentu.Info')
    end
  end

  context "An user tries to touch something forbidden" do
    it "is routed to the homepage" do
      viewer = create(:user)
      login_as(viewer)

      visit words_path

      expect(page).to have_css 'h2'
      expect(page).to have_content('papiamentu')
      expect(page).to have_content('buska un palabra')
    end
  end
end
