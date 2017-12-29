require 'rails_helper'

feature 'MyProfile' do

  context "Viewers visits its profile page", js: true do
    it "Successfully" do
      viewer = create(:user)
      login_as(viewer)

      visit my_profile_path

      expect(page).to have_content('new_words')
      expect(page).to have_content("Words I added: #{viewer.words.count}")
    end
  end

  context "Viewers changes its profile settings", js: true do
    it "Successfully" do
      viewer = create(:user)
      login_as(viewer)

      visit my_profile_path

      within(:css, "#user_#{viewer.id}_new_words") do
        click_link 'empty'
        select 'daily', from: '_user_new_words'
        click_button('ok')
      end

      within(:css, "#user_#{viewer.id}_own_words") do
        click_link 'empty'
        select 'weekly', from: '_user_own_words'
        click_button('ok')
      end

      within(:css, "#user_#{viewer.id}_most_voted") do
        click_link 'empty'
        select 'monthly', from: '_user_most_voted'
        click_button('ok')
      end

      wait_for_ajax
      viewer.reload

      expect(page).to have_content('daily')
      expect(viewer.new_words).to eq(3)

      expect(page).to have_content('weekly')
      expect(viewer.own_words).to eq(4)

      expect(page).to have_content('monthly')
      expect(viewer.most_voted).to eq(5)
    end
  end

end
