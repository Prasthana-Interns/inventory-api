require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe 'sessions /signin' do 
    before do
    @user = FactoryBot.create(:user)
    post '/users/signin', params: {
    user: {
      emp_id: @user.emp_id,
      password: "shiva123"
          }
    }
  end
    it 'render the status code to success' do
      byebug
      expect(response).to have_http_status(200)
    end
  end
end