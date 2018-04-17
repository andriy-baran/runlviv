class SessionsController < Devise::OmniauthCallbacksController
  def create

  end

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = auth_hash
      redirect_to new_user_registration_url
    end
  end

  def strava
    conn = Faraday.new('https://www.strava.com')
    res = conn.post(
            '/oauth/token',
            client_id: Rails.application.secrets.strava_client_id,
            client_secret: Rails.application.secrets.strava_api_key,
            code: params[:code]
          )
    user = User.find(params[:state])
    auth_info = JSON.parse(res.body)
    token = auth_info['access_token']
    athlete_id = auth_info.fetch('athlete', {})['id']
    user.update_columns(strava_athlete_id: athlete_id, strava_access_token: token)
    # client = Strava::Api::V3::Client.new(access_token: token)
    # client.join_a_club(440002)
    redirect_to profile_user_path(user), notice: 'Готово!'
  end

  def failure
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
