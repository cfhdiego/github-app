require 'rails_helper'

describe RepositoryCrawler do
  let(:languages) ['ruby', 'python', 'elixir', 'crystal', 'go']
  subject { described_class.new(languages) }

  context 'search top 5 repositories for languages' do
    repositories = subject.search_repositories
    languages.each do |language|
      it "should return 5 #{language} repositories" do
        expect(repositories.select { |rep| rep[:language] == "#{language}" }.size)
          .to eq(5)
      end
    end
  end
end
