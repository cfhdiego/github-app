# Service for github repository crawlling
class RepositoryCrawler
  attr_reader :languages

  def initialize(languages)
    @languages = languages
  end

  def search_repositories
    client = Octokit::Client.new(access_token: '293d7fd606f700752e276c84a68a6d223107efc2')
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
    search_repositories.each do |repository|
      existing_repositoty = Repository.where(name: repository[:full_name])
      if existing_repositoty.empty?
        Repository.create(name: repository[:full_name],
                          description: repository[:description],
                          github_url: repository[:html_url],
                          language: repository[:language],
                          site_url: repository[:homepage],
                          stars_count: repository[:stargazers_count],
                          watchers_count: repository[:watchers_count],
                          forks_count: repository[:forks_count])
      else
        existing_repositoty.take
                           .update_attributes(description: repository[:description],
                                              github_url: repository[:html_url],
                                              language: repository[:language].downcase,
                                              site_url: repository[:homepage],
                                              stars_count: repository[:stargazers_count],
                                              watchers_count: repository[:watchers_count],
                                              forks_count: repository[:forks_count])
      end
    end
  end
end
