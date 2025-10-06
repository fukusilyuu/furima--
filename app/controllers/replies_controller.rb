class RepliesController < ApplicationController
  def create
    @reply = Reply.new(reply_params)
    @comment = @reply.comment
    @replies = @comment.replies
    @reply.save
    redirect_to item_path(@reply.comment)
  end

  private

  def reply_params
    params.require(:reply).permit(:context).merge(user_id: current_user.id, item_id: params[:item_id],
                                                  comment_id: params[:comment_id])
  end
end
