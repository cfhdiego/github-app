class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.all.page params['page'] if params[:language].nil? || params[:language] == 'all'
    @repositories ||= Repository.where(language: params[:language]).page params['page']

    respond_to do |format|
      format.js
      format.html
    end
  end

  def search
    service = RepositoryCrawler.new(['ruby', 'python', 'go', 'elixir', 'crystal'])

    service.create_repositories

    redirect_to repositories_path
  end
end
