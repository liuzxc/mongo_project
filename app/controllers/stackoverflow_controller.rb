require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
class StackoverflowController < ApplicationController

  CLIENT_ID = ENV['SOF_BASIC_CLIENT_ID']
  CLIENT_SECRET = ENV['SOF_BASIC_SECRET_ID']

  def index
    if !authenticated?
      authenticate!
    else
      access_token = session[:access_token]
      begin
        auth_result = RestClient.get('https://api.stackexchange.com/2.2/me',
                                     {:params => {:access_token => access_token,
                                                  :key => "AweR6EdbuZBdvIb9wuCtDw((",
                                                  :site => 'stackoverflow'},
                                      :accept => :json})
      rescue => e
        session[:access_token] = nil
        return authenticate!
      end

      auth_result = JSON.parse(auth_result)
      Rails::logger.info("-----------auth_result#{auth_result.class}------------")
      user_info = auth_result["items"].first
       Rails::logger.info("-----------user_info#{user_info}------------")
      user = User.find_by(stack_id: user_info['account_id'])
      Rails::logger.info("-----------user_info['account_id'];;;#{user_info['account_id']}------------")
      if not user
        password = SecureRandom.hex(8)

        user_attr = {user_name: user_info['display_name'],
                     email: user_info['account_id'].to_s + "@test.com",
                     stack_id: user_info['account_id'],
                     avatar_url: user_info['profile_image'],
                     location: user_info['location'],
                     password: password,
                     password_confirmation: password,
                    }
        user = User.create!(user_attr)
      end
      session[:user_id] = user.id
      # if scopes.include? 'user:email'
      #   auth_result['private_emails'] =
      #     JSON.parse(RestClient.get('https://api.github.com/user/emails',
      #                    {:params => {:access_token => access_token},
      #                     :accept => :json}))
      # end
      redirect_to user_path(id: user.id)
    end
  end

  def authenticated?
    session[:access_token]
  end

  def authenticate!
  # def index
    Rails::logger.info("-------------CLIENT_ID:::#{CLIENT_ID}-----------")
    render :index, :locals => {:client_id => CLIENT_ID}
  end

  def callback
    # get temporary GitHub code...
    Rails::logger.info("--------------++++++++++++++++++#{request.env['rack.request.query_hash']}----------")
    session_code = request.env['rack.request.query_hash']['code']
    # ... and POST it back to GitHub
    result = RestClient.post('https://stackexchange.com/oauth/access_token',

                            {:client_id => CLIENT_ID,
                             :client_secret => CLIENT_SECRET,
                             :code => session_code,
                             :redirect_uri => 'http://rails.example.com:3000/stackoverflow/callback',
                             :verify_ssl => false,}
                             )
    # extract the token and granted scopes
    Rails::logger.info("---------+++++++++++token::::#{result.split("=")[1]}----------------")
    session[:access_token] = result.split("=")[1]
    redirect_to stackoverflow_path
  end

end