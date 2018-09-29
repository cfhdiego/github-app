# Service for github repository crawlling
class RepositoryCrawler
  attr_reader :languages

  def initialize(languages)
    @languages = languages
  end

  def search_repositories
    client = Octokit::Client.new(access_token: '34b8a422c2a933e101c377186d079ed55a8e0d37')
    repositories = []
    languages.each do |language|
      repositories << client.search_repositories("language:#{language}",
                                                 sort: 'stars',
                                                 page: 1,
                                                 per_page: 5)[:items]
    end
    repositories.flatten
  end

  def create_repositories
    Repository.delete_all
    search_repositories.each do |repository|
      Repository.create(name: repository[:full_name],
                        description: repository[:description],
                        github_url: repository[:html_url],
                        language: repository[:language].downcase,
                        site_url: repository[:homepage],
                        stars_count: repository[:stargazers_count],
                        watchers_count: repository[:watchers_count],
                        forks_count: repository[:forks_count])
    end
  end
end
