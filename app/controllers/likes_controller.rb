class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item_like
  before_action :set_likeable

  def create
    current_user.likes.create!(likeable: @item)

    current_user.create_like_notification!(current_user, @item) if @item.user_id != current_user.id

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to item_path(@item) }
    end
  end

  def destroy
    current_user.likes.find_by(likeable: @item)&.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to item_path(@item) }
    end
  end

  private

  def set_item_like
    @item = Item.find(params[:item_id])
  end

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
