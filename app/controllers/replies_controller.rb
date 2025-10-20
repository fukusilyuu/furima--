class RepliesController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @comment = @item.comments.find(params[:comment_id])
    @reply = @comment.replies.new(reply_params)
    @reply.user_id = current_user.id # ログイン中ユーザーを紐づける場合

    if @reply.save
      redirect_to item_path(@item), notice: '返信を投稿しました'
    else
      render 'items/show', status: :unprocessable_entity
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:context).merge(user_id: current_user.id, item_id: params[:item_id],
                                                  comment_id: params[:comment_id])
  end
end
