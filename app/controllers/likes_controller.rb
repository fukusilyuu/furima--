class LikesController < ApplicationController
  before_action :set_likeable

  def create
    @likeable.likes.find_or_create_by(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @likeable.likes.where(user: current_user).destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def set_likeable
    @likeable = if params[:reply_id]
                  Reply.find(params[:reply_id])
                elsif params[:comment_id]
                  Comment.find(params[:comment_id])
                else
                  Item.find(params[:item_id])
                end
  end
end
