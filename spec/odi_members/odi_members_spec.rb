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

    context 'create new member' do
      it 'posts to the endpoint' do
        user = ENV['MEMBERS_API_USERNAME']
        pw = ENV['MEMBERS_API_PASSWORD']

        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)

        content = {
          name: 'Bert'
        }.to_json

        post '/members/123', content, JSON_HEADERS
        expect(Member.count).to eq 1
      end
    end
  end
end
