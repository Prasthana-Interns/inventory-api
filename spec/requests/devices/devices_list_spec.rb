require 'rails_helper'  

RSpec.describe "Devices", type: :request do
  let!(:device) { FactoryBot.create_list(:device,10) }
  describe 'GET #index' do
    context 'when user is admin ' do

      it 'returns all posts' do
        get '/devices', headers:{ 'Authorization': login_admin['token'] }  
        expect(JSON(response.body).count).to eq(10)
      end
      it 'should give the status code  as 200' do
        get '/devices', headers:{ 'Authorization': login_admin['token'] }
        expect(response.status).to eq(200)
      end
    end
  end
end
