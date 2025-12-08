class LikesController < ApplicationController
  before_action :set_likeable

  def create
    @likeable.likes.find_or_create_by(user: current_user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
  end

  def destroy
    @likeable.likes.where(user: current_user).destroy_all

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
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
