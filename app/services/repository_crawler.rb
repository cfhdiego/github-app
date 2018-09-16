# Service for github repository crawlling
class RepositoyCrawler
  attr_reader :languages

  def initialize(languages)
    @languages = languages
  end

  def search_repository
    client = Octokit::Client.new

    repositories = client.search_repositories("language:#{languages.join(',')}",
                                              sort: 'stars',
                                              page: 1,
                                              per_page: 5)[:items]
    create_repositories(repositories)
  end

  def create_repositories(repositories)
    repositories.each do |repository|
      Repository.create(name: repository[:name],
                        description: repository[:description],
                        github_url: repository[:github_url],
                        language: repository[:language],
                        site_url: repository[:site_url],
                        stars_count: repository[:stars_count],
                        watchers_count: repository[:watchers_count],
                        forks_count: repository[:forks_count])
    end
  end
end
