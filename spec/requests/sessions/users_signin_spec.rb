require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  describe 'sessions /signin' do 
    context 'user logged in with correct credentials' do
      before do
        post '/users/signin', params:
        {
          user:{ emp_id: user.emp_id,password: "shiva123" }
        }
      end
      it 'render the status code as success' do
        expect(response.status).to eq(200)
      end
    end
  end
end
