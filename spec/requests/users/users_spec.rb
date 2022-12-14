require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET /index' do
    let!(:user) { create(:user) }
      it ' signing in user' do
       post '/users/signin', params: {
        user: {
          emp_id:user.emp_id,
          password: "shiva123" }
        }
      @result= JSON.parse(response.body)
      @token = @result['token']
      get '/users', headers:{ 'Authorization': @token } 
    end
    it 'returns all posts' do
      expect(JSON(response.body).count).to eq(1)
    end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
  end
end

