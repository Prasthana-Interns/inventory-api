require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "PUT #update" do

    context 'with valid parameters' do
      before do
        put "/users/#{login_admin['user']['id']}",headers:{ 'Authorization': login_admin['token'] }, params: {
          user: {
          name: "prasthana",
          approved: false,
          password: "shiva123"
          }
        }
      end
      it  "gives the status code 200" do
        expect(response.status).to eq(200)
      end
    end

    context 'with invalid parameters' do
      before do
        put "/users/#{login_employee['user']['id']}",headers:{ 'Authorization': login_employee['token'] }, params: {
          user: {
          name: "prasthana",
          approved: false,
          password: "shiva123"
          }
        }
      end
      it  "gives the response code 401" do
        expect(response.body).to eq("Unauthorized")
      end
    end

  end
end