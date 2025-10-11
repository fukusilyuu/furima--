class LikesController < ApplicationController
  def create
    like = current_user.likes.build(user_id: current_user.id, item_id: params[:id])
    like.save
    redirect_to root_path
  end

  def destroy
    like = Like.find_by(item_id: params[:item_id], user_id: current_user.id)
    like.destroy
    redirect_to root_path
  end
end
