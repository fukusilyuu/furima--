class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[edit update destroy]
  before_action :set_item, only: %i[update destroy]

  def new
    @comment = Comment.new
  end

  def create
    @reply = Reply.new

    @comment = Comment.new(comment_params)
    @comment.user = current_user
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
    return if @comment.user == current_user

    redirect_to root_path, alert: '権限がありません。'
  end

  def update
    if @comment.user == current_user
      if @comment.update(comment_params)
        redirect_to @item, notice: 'コメントを編集しました'
      else
        render 'items/show', status: :unprocessable_entity
      end
    else
      redirect_to @item, alert: '編集権限がありません'
    end
  end

  def destroy
    return unless @comment.user == current_user

    if @comment.destroy
      redirect_to @item, notice: 'コメントを削除しました'
    else
      redirect_to @item, alert: '他のユーザーのコメントは削除できません'
    end
    return if @item.comments.nil?

    redirect_to item_path
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_comment
    @comment = Comment.find(params[:comment_id] || params[:id])
    redirect_to root_path, alert: '商品が見つかりません。' unless @comment
  end
end
