class OrdersController < ApplicationController
  before_action :set_order, only: [:index,:create]
  require 'payjp'
  def index
    @order = OrderAddress.new
  end

  def create
    @order = OrderAddress.new(order_params)
    if @order.valid?
      pay_order
      @order.save
      return redirect_to root_path
    else
      render 'index', status: :unprocessable_entity
    end
  end
  private
  def set_order
    @item = Item.find(params[:item_id])
    if @item.user.id == current_user.id
      redirect_to root_path
    end
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_order
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token], 
      currency: 'jpy'             
    )
  end
end
