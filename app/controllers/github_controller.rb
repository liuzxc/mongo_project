
class GithubController < ApplicationController

  CLIENT_ID = ENV['GH_BASIC_CLIENT_ID']
  CLIENT_SECRET = ENV['GH_BASIC_SECRET_ID']

  def index
    if !authenticated?
      authenticate!
    else
      access_token = session[:access_token]
      scopes = []

      begin
        auth_result = RestClient.get('https://api.github.com/user',
                                     {:params => {:access_token => access_token},
                                      :accept => :json})
      rescue => e
        # request didn't succeed because the token was revoked so we
        # invalidate the token stored in the session and render the
        # index page so that the user can start the OAuth flow again

        session[:access_token] = nil
        return authenticate!
      end

      # the request succeeded, so we check the list of current scopes
      if auth_result.headers.include? :x_oauth_scopes
        scopes = auth_result.headers[:x_oauth_scopes].split(', ')
      end

      auth_result = JSON.parse(auth_result)
      Rails::logger.info("-----------auth_result#{auth_result}------------")

      user = User.find_by(github_id: auth_result["id"])
      if not user
        password = SecureRandom.hex(8)
        user_attr = {user_name: auth_result["login"],
                     email: auth_result["email"],
                     github_id: auth_result["id"],
                     avatar_url: auth_result["avatar_url"],
                     location: auth_result["location"],
                     password: password,
                     password_confirmation: password,
                    }
        user = User.create!(user_attr)
      end
      session[:user_id] = user.id
      if scopes.include? 'user:email'
        auth_result['private_emails'] =
          JSON.parse(RestClient.get('https://api.github.com/user/emails',
                         {:params => {:access_token => access_token},
                          :accept => :json}))
      end
      redirect_to user_path(id: user.id)
    end
  end

  def authenticated?
    session[:access_token]
  end

  def authenticate!
    render :index, :locals => {:client_id => CLIENT_ID}
  end

  def callback
    # get temporary GitHub code...
    session_code = request.env['rack.request.query_hash']['code']
    # ... and POST it back to GitHub
    result = RestClient.post('https://github.com/login/oauth/access_token',
                            {:client_id => CLIENT_ID,
                             :client_secret => CLIENT_SECRET,
                             :code => session_code},
                             :accept => :json)
    # extract the token and granted scopes
    session[:access_token] = JSON.parse(result)['access_token']
    redirect_to github_path
  end

end