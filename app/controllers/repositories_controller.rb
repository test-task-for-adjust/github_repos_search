class RepositoriesController < ApplicationController
  def index
    @search_results = RepositoriesService.new(params['query']).perform
  end
end
