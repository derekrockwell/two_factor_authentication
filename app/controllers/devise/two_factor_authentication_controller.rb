class Devise::TwoFactorAuthenticationController < DeviseController
  prepend_before_filter :authenticate_scope!
  before_filter :prepare_and_validate, :handle_two_factor_authentication

  def show
  end

  def update
    render :show and return if params[:code].nil?
    md5 = Digest::MD5.hexdigest(params[:code])
    if md5.eql?(resource.second_factor_pass_code)
      warden.session(resource_name)[:need_two_factor_authentication] = false
      sign_in resource_name, resource, :bypass => true
      redirect_to stored_location_for(resource_name) || :root
      #add remembered cookie
      resource.tfa_remember!
      cookies.signed["tfa_token"] = tfa_cookie_values(resource)
      resource.update_attribute(:second_factor_attempts_count, 0)
    else
      resource.second_factor_attempts_count += 1
      resource.save
      set_flash_message :error, :attempt_failed
      if resource.max_login_attempts?
        sign_out(resource)
        render :template => 'devise/two_factor_authentication/max_login_attempts_reached' and return
      else
        render :show
      end
    end
  end

  private

    def tfa_cookie_values(resource)
      options = { :httponly => true }
      options.merge!(
        :value => resource.class.serialize_tfa_cookie(resource),
        :expires => resource.tfa_remember_expires_at
      )
    end

    def authenticate_scope!
      self.resource = send("current_#{resource_name}")
    end

    def prepare_and_validate
      redirect_to :root and return if resource.nil?
      @limit = resource.class.max_login_attempts
      if resource.max_login_attempts?
        sign_out(resource)
        render :template => 'devise/two_factor_authentication/max_login_attempts_reached' and return
      end
    end
end
