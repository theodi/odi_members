module OdiMembers
  JSON_HEADERS = { 'HTTP_ACCEPT' => 'application/json' }

  describe App do
    it 'says hello' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to match /Hello from OdiMembers/
    end

    it 'serves JSON' do
      get '/', nil, JSON_HEADERS
      expect(last_response).to be_ok
      expect(JSON.parse last_response.body).to eq (
        {
          'app' => 'OdiMembers'
        }
      )
    end
  end
end
