require 'rails_helper'

describe RepositoryCrawler do
  languages = %w[Ruby Python Go Elixir Crystal]
  subject { described_class.new(languages) }

  context 'search top 5 repositories for languages' do
    languages.each do |language|
      it "should return 5 #{language} repositories" do
        expect(subject.search_repositories
          .select { |rep| rep[:language] == language }.size)
          .to eq(5)
      end
    end
  end

  context 'create_repositories' do
    it 'should create 25 new repositories' do
      expect { subject.create_repositories }
        .to change { Repository.count }
        .by(25)
    end
  end
end
