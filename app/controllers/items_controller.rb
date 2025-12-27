class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: %i[show edit update destroy]
  before_action :set_edit_destroy, only: %i[edit destroy]
  def index
    @items = Item.includes(:user).order('created_at DESC')
    @user = User.new
    @users = User.all
    @q = Item.ransack(params[:q])
    @items = @q.result.limit(5)
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
    @user = User.new
    @comment = Comment.new
    @reply = Reply.new
    @user = User.find(params[:id])
    @users = User.all
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

  def search
    keyword = params[:keyword]

    @names = Item.where('name LIKE ?', "%#{keyword}%").limit(10).pluck(:name)

    render json: @names
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :price, :explanation, :genre_id, :quality_id, :payment_id,
                                 :prefecture_id, :days_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find_by(id: params[:item_id] || params[:id])
    redirect_to root_path, alert: '商品が見つかりません。' unless @item
  end

  def set_edit_destroy
    return if current_user.id == @item.user.id

    redirect_to root_path
  end
end
