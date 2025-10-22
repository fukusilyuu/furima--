class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  before_action :set_item, only: %i[update destroy]

  def new
    @comment = Comment.new
  end

  def create
    @reply = Reply.new

    @comment = Comment.new(comment_params)
    @comment.user = current_user
    # @item = Item.find(params[:item_id])
    if @comment.save
      redirect_to item_path(@comment.item)
      CommentChannel.broadcast_to @item, { comment: @comment, user: @comment.user }

    else
      @item = @comment.item
      @comments = @item.comments
      @replies = @comment.replies
      render 'items/show'
    end
  end

  def edit
  end

  def update
    if @comment.user == current_user
      if @comment.update(comment_params)
        redirect_to @item, notice: 'コメントを編集しました'
      else
        redirect_to @item, alert: 'コメントの編集に失敗しました'
      end
    else
      redirect_to @item, alert: '編集権限がありません'
    end
  end

  def destroy
    return unless @comment.destroy

    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
