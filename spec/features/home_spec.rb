require 'rails_helper'

feature 'repository index', js: true do
  before do
    host = 'localhost:3000'
    default_url_options[:host] = host
    Capybara.app_host = 'http://' + host
  end

  context 'repositories index' do
    languages = %w[Ruby Python Go Elixir Crystal]

    it 'list all repositories' do
      visit repositories_path

      expect(page).to have_content('Repository Crawler')

      click_on 'Search Repositories'

      select 'All', from: 'language'

      languages.each do |language|
        expect(page).to have_content(language)

        expect(page.find_all('.repository__row').count).to eq(5)

        click_on 'Next ›' unless language == 'Crystal'
      end
    end

    languages.each do |language|
      it "list #{language} repositories by filter" do
        visit repositories_path

        select language , from: 'language'

        expect(page).to have_content(language)

        expect(page.find_all('.repository__row').count).to eq(5)
      end
    end
  end

end
