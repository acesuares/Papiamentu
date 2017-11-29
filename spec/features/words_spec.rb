require 'rails_helper'

feature 'Words' do

  context "when creating a new word", js: true do
    it "Successfully" do
      superadmin = create(:user, :superadmin)
      login_as(superadmin)

      visit "#{words_path}?update=words_list"
      page.execute_script('$(".new_button").click()')
      fill_in 'name', with: 'alfabetisashon'
      click_button 'ok'

      wait_for_ajax

      expect(Word.find_by_name('alfabetisashon').nil?).to eq(false)
      expect(page).to have_content 'alfabetisashon () (menos ku 1 minüt ago)'
    end

    it "requires the attribute name for persistence" do
      superadmin = create(:user, :superadmin)
      login_as(superadmin)

      visit "#{words_path}?update=words_list"
      page.execute_script('$(".new_button").click()')
      click_button 'ok'

      wait_for_ajax

      expect(page).to have_content 'entrada no por ta bashí'
    end
  end

  context "Updating a word", js: true do
    it "Successfully" do
      word = create(:word, name: 'alfabetisashon')
      login_as(word.user)

      visit "#{words_path}?update=words_list"
      within(:css, "#word_#{word.id}") do
        within(:css, ".small-11") do
          click_link
        end

        within(:css, "#word_#{word.id}_attested") do
          click_link
          within(:css, ".edit_form") do
            choose('attested_standarized')
            click_button('ok')
          end
        end
      end
      wait_for_ajax

      word = Word.find_by_name('alfabetisashon')

      expect(word.standarized?).to eq(true)
    end
  end
end
