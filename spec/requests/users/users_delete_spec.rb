require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "DELETE #destroy" do

    context 'when admin try to  delete the particular record' do
    
      it 'returns a success status' do
        delete "/users/#{login_admin['user']['id']}",headers:{ 'Authorization': login_admin['token'] }
        expect(response.status).to eq(200)
      end

    end

    context 'when employee try  to delete a record' do
    
      it ' render the message as  Unauthorized ' do
        delete "/users/#{login_employee['user']['id']}",headers:{ 'Authorization': login_employee['token'] }
        expect(JSON(response.body)).to eq("error"=>"unauthorized")
      end

    end
  end

end