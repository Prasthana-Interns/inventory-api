require 'rails_helper'

RSpec.describe "Devices", type: :request do

  describe 'POST #create' do

    context 'when user is an admin' do
      before do
        post '/devices' ,headers:{ 'Authorization': login_admin['token'] },params: {
          device:{
          name: "Lenovo IdeaPad",
          device_type: "laptop",
          os: "windows",
          user_id: login_admin['id']
          }
        } 
      end
      it 'should render status code as success' do
        expect(response.status).to eq(200)
      end

      it 'render the name of a device' do
        expect(JSON(response.body).name).to eq("Lenovo IdeaPad")
      end
    end

  end

end