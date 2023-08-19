class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    flash[:alert] = "▽ログインに成功しました！"
    posts_top_path

  end


  def after_sign_out_path_for(resource)
    flash[:alert] = "▽ログアウトに成功しました！"
    root_path

  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :account_id])
  end
end
