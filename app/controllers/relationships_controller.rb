class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    respond_to do |format|
      format.html { redirect_to request.referer || root_path }
      format.turbo_stream
    end
  end

  def destroy
    relationship = Relationship.find(params[:id])
    user = relationship.followed
    current_user.unfollow(user)
    respond_to do |format|
      format.html { redirect_to request.referer || root_path }
      format.turbo_stream
    end
  end
end
