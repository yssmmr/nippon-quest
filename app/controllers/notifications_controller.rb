class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update_attribute(:checked, true)
    end
  end

  #通知を全削除
  def destroy_all
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path, alert: "▽通知を全削除しました！"
  end
end
