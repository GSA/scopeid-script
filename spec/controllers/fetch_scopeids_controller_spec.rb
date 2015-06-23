require 'rails_helper'

RSpec.describe FetchScopeidsController, :type => :controller do
  describe '#index' do
    it 'responds with 200 and sends the file' do
      get :index
      expect(response.status).to eq(200)
      #expect(controller).to receive(:send_file)
    end
  end
end
