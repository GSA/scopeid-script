require 'rails_helper'

RSpec.describe FetchScopeidsController, :type => :controller do
  top_terms_fixture = "#{Rails.root}/spec/fixtures/top_terms.xml"
  nested_terms_fixtures = "#{Rails.root}/spec/fixtures/nested_terms/%d.xml"
  test_csv = "#{Rails.root}/spec/lib/spec_csv_result.csv"

  converter = ScopeidConverter.new(top_terms_fixture, nested_terms_fixtures, test_csv)

  describe '#index' do
    it 'responds with 200 and sends the file' do
   		allow(controller).to receive(:build_scopeid_converter).and_return(converter)
      expect(controller).to receive(:send_file)
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe '#build_scopeid_converter' do
    it 'builds a new converter' do
      expect(controller.build_scopeid_converter).to be_a ScopeidConverter
    end
  end
end
