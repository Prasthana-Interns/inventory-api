require 'rails_helper'  

RSpec.describe "Users", type: :request do
  describe 'GET #index' do
    context 'when user is admin and employee' do

      it 'returns all users' do
        get '/users', headers:{ 'Authorization': login_admin['token'] }
        expect(JSON(response.body).count).to eq(2)
      end
      it 'gives status code 200' do
        get '/users', headers:{ 'Authorization': login_admin['token'] }
        expect(response).to have_http_status(200)
      end
    end

    context 'when user is employee' do
      it 'returns status code 401' do
        get '/users', headers:{ 'Authorization': login_employee['token'] }
        expect(response).to have_http_status(401)
      end
    end

  end
end