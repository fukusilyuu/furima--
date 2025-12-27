class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)

    # フォロー通知
    @user.create_follow_notification!(current_user)

    # 相互フォローになったら通知
    if @user.following?(current_user)
      @user.create_mutual_notification!(current_user)
      current_user.create_mutual_notification!(@user)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @user }
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
  end
end
