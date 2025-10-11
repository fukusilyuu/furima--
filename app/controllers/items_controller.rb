class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_item, only: %i[show edit update destroy]
  before_action :set_edit_destroy, only: %i[edit destroy]
  def index
    @items = Item.includes(:user).order('created_at DESC')
    like = current_user.likes.build(item_id: params[:item_id])
    follow = current_user.active_relationships.new(follower_id: params[:user_id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.new
    @reply = Reply.new
    @comments = @item.comments.includes(:user)
    @replies = @comment.replies.includes(:user)
  end

  def edit
    return if @item.order.nil?

    redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @item.destroy

    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :price, :explanation, :genre_id, :quality_id, :payment_id,
                                 :prefecture_id, :days_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_edit_destroy
    return if current_user.id == @item.user.id

    redirect_to root_path
  end
end
