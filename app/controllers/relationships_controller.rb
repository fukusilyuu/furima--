class RelationshipsController < ApplicationController
  def create
    follow = current_user.active_relationships.new(follower_id: params[:item_id], follower_id: params[:user_id])
    follow.save
    redirect_to item_path
  end

  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:item_id], follower_id: params[:user_id])
    follow.destroy
    redirect_to root_path
  end
end
