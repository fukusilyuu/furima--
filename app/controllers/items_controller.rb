class ItemsController < ApplicationController
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
  private
  def item_params
    params.require(:item).permit(:name, :image, :price, :explanation, :genre_id, :quality_id, :payment_id, :prefecture_id, :days_id).merge(user_id: current_user.id)
  end
end
