class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :admin?
  # before_filter :user_signed_in?

  def require_admin
    if not admin?
      flash[:error] = "您没有权限操作！"
      redirect_to home_path
    end
  end

  def require_login
    if not logged_in?
      flash[:error] = "请登录！"
      redirect_to log_in_path
    end
  end

  def validate_user
    Rails::logger.info("test----------#{params[:user_id]} and #{current_user.id.class} and #{current_user.id.to_s != params[:user_id]}")
    if current_user.id.to_s != params[:user_id]
      Rails::logger.info("----------非法操作")
      flash[:error] = "非法操作！"
      redirect_to home_path
    end
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.nil? ? false : true
  end

  def admin?
    current_user.admin
  end
end
