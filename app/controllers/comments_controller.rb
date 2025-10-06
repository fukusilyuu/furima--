class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to item_path(@comment.id)
    else
      @item = Item.find(params[:id])
      @item = @comment.item
      @comments = @item.comments
      render 'items/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
