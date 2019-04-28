class RepositoriesService
  def initialize(search_query)
    @search_query = search_query
  end

  def perform
    return [] unless @search_query

    client.search_repositories(@search_query).items
  rescue StandardError => e
    Rails.logger.error [e.message, *e.backtrace].join($/)
    []
  end

  private

  def client
    @client ||= Octokit::Client.new
  end
end