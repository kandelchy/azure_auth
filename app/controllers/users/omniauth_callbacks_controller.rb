
require 'jwt'

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def azure_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Azure AD') if is_navigational_format?

      # Retreive access token and decode it using JWT then print it to the console
      token = request.env["omniauth.auth"]["credentials"]["token"]
      decoded_token = JWT.decode token, nil, false
      # puts "*****************"
      # puts decoded_token
      # puts "*****************"

      url = URI('http://52.170.88.55/Discovery.Auth.API/api/Token/GetSecurityToken')
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = false
      request = Net::HTTP::Post.new(url, {'Content-Type' => 'application/json'})
      data = {"UserName":"Bassam@NitorSSO.onmicrosoft.com","Password":"NI@2018123","ClientId":"8e59734f-420f-47bf-b8e7-f9d8415b4e4d"}
      data_json = data.to_json
      request.body = data_json
      response = http.request(request)
      # puts "*****************"
      $role = response.body
      # puts "*****************"

    else
      session['devise.azure_oauth2_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end



  end

  def failure
    redirect_to root_path
  end
end
