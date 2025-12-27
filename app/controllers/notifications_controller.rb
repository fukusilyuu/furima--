class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications
    @notifications.update_all(checked: true)
  end

  def destroy
    @notification = current_user.passive_notifications.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to notifications_path }
    end
  end

  def destroy_all
    current_user.passive_notifications.destroy_all

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to notifications_path }
    end
  end
end
