class RepliesController < ApplicationController
  def create
    @comment = Comment.new
    @reply = Reply.new(reply_params)
    @comment = @reply.comment
    @replies = @comment.replies
    if @reply.save
      redirect_to item_path(@comment.reply)
    else
      render 'items/show'
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:context).merge(user_id: current_user.id, item_id: params[:item_id],
                                                  comment_id: params[:comment_id])
  end
end
