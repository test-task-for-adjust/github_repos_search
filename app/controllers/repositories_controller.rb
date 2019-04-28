class RepositoriesController < ApplicationController
  def index
    @search_results = RepositoriesService.new(params['query']).perform
  rescue StandardError
    flash[:alert] = 'Error occured while fetching repositories'
    @search_results = []
  end
end
