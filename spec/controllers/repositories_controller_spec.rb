RSpec.describe RepositoriesController, type: :controller do
  render_views
  describe 'root path' do
    context 'when no params passed' do
      it do
        get :index
        expect(response).to have_http_status(:success)
        expect(response.parsed_body.scan(/Owner/).count).to(eq(0))
      end
    end

    context 'when query passed', :vcr do
      it do
        get :index, params: { query: 'asd' }
        expect(response).to have_http_status(:success)
        expect(response.parsed_body.scan(/Owner/).count).to(eq(30))
      end
    end

    context 'when query passed and error happened' do
      before {allow_any_instance_of(RepositoriesService).to(receive(:client).and_raise(StandardError))}

      it do
        get :index, params: { query: 'asd' }
        expect(response).to have_http_status(:success)
        expect(response.parsed_body).to(include('Error occured while fetching repositories'))
      end
    end
  end
end