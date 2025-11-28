class ItemsController < ApplicationController
  before_action :authenticate_user!, expect: %i[index show]
  before_action :set_item, only: %i[show edit update destroy]
  before_action :set_edit_destroy, only: %i[edit destroy]
  def index
    @items = Item.includes(:user).order('created_at DESC')
    @users = User.all
    @q = Item.ransack(params[:q])
    @items = @q.result.limit(5)

    # Ajax / Turbo Streams の場合は部分テンプレートのみ返す
    return unless request.headers['Accept']&.include?('text/vnd.turbo-stream.html')

    render partial: 'shared/search_suggestions', locals: { items: @items }
    nil

    respond_to do |format|
      format.html
      format.turbo_stream { render partial: 'shared/search_suggestions', locals: { items: @items } }
    end
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
    items = Item.where('name LIKE ?', "%#{params[:keyword]}%")
    render json: items.select(:id, :name)
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
