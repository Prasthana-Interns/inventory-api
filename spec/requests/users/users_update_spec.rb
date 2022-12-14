require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "PUT /users" do
    let!(:user) { create :user } 

    context 'with valid parameters' do
      before do
        put "/users/#{user.id}", params: {
          user: {
          name: "prasthana",
          password: "shiva123"
          }
        }
      end
        it  "it update's the user attributes" do
          expect(response.status).to eq(200)
        end
    end
  end
end