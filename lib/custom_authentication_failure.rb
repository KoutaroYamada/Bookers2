class CustomAuthenticationFailure < Devise::FailureApp
  protected
    def redirect_url
      user_session_path
  #    root_path+"users/auth/facebook" #自動でfacebook認証させる場合
    end
  end
