require 'rails_helper'
require 'requests/sessions/users_signin_spec.rb'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }
    describe 'GET /index' do
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

