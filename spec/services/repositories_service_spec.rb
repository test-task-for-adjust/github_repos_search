RSpec.describe RepositoriesService do
  describe '#perform' do
    subject { service.perform }

    let(:service)     { described_class.new(search_term) }
    let(:search_term) { 'asd' }

    context 'when no errors happen', :vcr do
      it {is_expected.to(be_kind_of(Array))}
    end

    context 'when unexpected error happens amid fetching' do
      before { allow(service).to(receive(:client).and_raise(StandardError)) }

      it {
        expect(Rails.logger).to(receive(:error))
        expect{ subject }.to(raise_error(StandardError))
      }
    end
  end
end