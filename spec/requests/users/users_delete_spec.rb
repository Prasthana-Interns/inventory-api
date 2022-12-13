require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "DELETE /destroy" do
    user = FactoryBot.create(:user)
    context 'it delete the particular user with id' do
      before do
       delete "/users/#{user.id}"
      end
      it 'returns a success status' do
        expect(response.status).to eq(200)
      end
    end
  end
end