require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe 'GET  #pending_request' do

    context 'when user is an admin' do
      before do 
        get '/users/pending_users',headers: {'Authorization': login_admin['token'] }
      end
      it 'should give the status code as 204 if empty' do
        expect(response.status).to eq(204)
      end
    end

  end

end