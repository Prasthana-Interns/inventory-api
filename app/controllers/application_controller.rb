class ApplicationController < ActionController::API

  SECRET_KEY = Rails.application.credentials.secret_key

  def encode_token(payload,exp:Time.now+24.hours)
    payload[:exp] = exp.to_i
    JWT.encode(payload,'SECRET_KEY')
  end

  def authorize_admin_token
    token_header = request.headers["Authorization"]
    if token_header
      token = token_header.split(" ")[0]
      begin
        decoded_token=  JWT.decode(token,'SECRET_KEY')
        user_id = decoded_token[0]['user_id']
        @current_user = User.find_by(id: user_id)
      rescue ActiveRecord::RecordNotFound => e
        render json: {errors: e.messages},status: :unauthorized
      rescue JWT::DecodeError => e
        render json: {errors: e.messages},status: :unauthorized
      end
    end
  end

end
