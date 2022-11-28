class ApplicationController < ActionController::API

  SECRET_KEY = Rails.application.credentials.secret_key
  def encode_token(payload,exp:Time.now+24.hours)
    payload[:exp] = exp.to_i
    JWT.encode(payload,'SECRET_KEY')
  end

  def decode_token
    token_header = request.headers["Authorization"]
    if token_header
      token = token_header.split(" ")[0]
      begin
          JWT.decode(token,'SECRET_KEY')
      rescue JWT::DecodeError => e    
      end
    end
  end

  def authorized_user
    decoded_token = decode_token
    if decoded_token
      @current_user = decoded_token[0]['emp_id']
    end 
  end

  def authorized 
    render json: "You need to log in to access this application",status: :unauthorized unless authorized_user
  end

end
