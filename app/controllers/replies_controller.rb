class RepliesController < ApplicationController
  before_action :set_item, only: %i[edit create update destroy]
  before_action :set_comment, only: %i[edit update destroy]
  before_action :set_reply, only: %i[edit update destroy]
  before_action :authenticate_user!, only: %i[edit update destroy]

  def create
    @user = current_user
    @comment = @item.comments.find(params[:comment_id])
    @reply = @comment.replies.new(reply_params)
    @reply.user == current_user
    if @reply.save
      redirect_to item_path(@item), notice: '返信を投稿しました'
    else
      render 'items/show', status: :unprocessable_entity
    end
  end

  def edit
    return if @reply.user == current_user

    redirect_to root_path, alert: '権限がありません。'
  end

  def update
    if @reply.user == current_user
      if @reply.update(reply_params)
        redirect_to @item, notice: 'コメントを編集しました'
      else
        render 'items/show', status: :unprocessable_entity
      end
    else
      redirect_to @item, alert: '編集権限がありません'
    end
  end

  def destroy
    if @reply.user == current_user
      @reply.destroy
      redirect_to @item, notice: 'コメントを削除しました'
    else
      redirect_to @item, alert: '他のユーザーのコメントは削除できません'
    end
    return if @item.comments.nil?

    redirect_to item_path
  end

  private

  def set_item
    @item = Item.find_by(id: params[:item_id])
    Rails.logger.info "🟦 set_item: params[:item_id]=#{params[:item_id]}, item=#{@item&.id}"
    redirect_to root_path, alert: '商品が見つかりません。' unless @item
  end

  def set_comment
    @comment = @item.comments.find_by(id: params[:comment_id]) if @item
    Rails.logger.info "🟩 set_comment: params[:comment_id]=#{params[:comment_id]}, comment=#{@comment&.id}"
    redirect_to root_path, alert: 'コメントが見つかりません。' unless @comment
  end

  def set_reply
    @reply = @comment.replies.find_by(id: params[:id]) if @comment
    Rails.logger.info "🟨 set_reply: params[:id]=#{params[:id]}, reply=#{@reply&.id}"
    redirect_to root_path, alert: '返信が見つかりません。' unless @reply
  end

  def reply_params
    params.require(:reply).permit(:context).merge(user_id: current_user.id, item_id: params[:item_id],
                                                  comment_id: params[:comment_id])
  end
end
