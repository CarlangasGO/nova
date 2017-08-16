class Backend::OmniauthController < Devise::OmniauthCallbacksController

    
  # facebook callback
  def facebook
    identify = Identify.create_from_oauth_data(request.env['omniauth.auth'])

    @member = identify.member

    if @member.persisted?
      sign_in_and_redirect @member
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      flash[:error] = 'There was a problem signing you in through Facebook. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end 
  end


  # twitter callback
  def twitter
    identify = Identify.create_from_oauth_data(request.env['omniauth.auth'])

    @member = identify.member

    if @member.persisted?
      sign_in_and_redirect @member
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
    else
      flash[:error] = 'There was a problem signing you in through Twitter. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end 
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.' 
    redirect_to new_user_registration_url
  end
end
