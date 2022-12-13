require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /create" do

    context 'with valid parameters' do
          before do
            post '/users', params: {  
              user:{
                name: "shiva",
                email: "argulashiva123@gmail.com",
                phone_number:  9876543210,
                designation:  "Developer", 
                approved:  true 
              },
              roles: ["Admin","Employee"] }
          end      
      it 'returns a created status' do
        expect(response).to have_http_status(201)
      end    
    end

    context 'with invalid parameters' do
          before do
            post '/users', params: {  
              user:{
                name: "shiva",
                email: "argulashiva123@gmailcom",
                phone_number:  9876543210,
                designation:  "Developer", 
                approved:  true 
              },
              roles: ["Admin","Employee"] }
          end      
      it 'returns a bad request' do
        expect(response).to have_http_status(400)
      end    
    end
  end
end
