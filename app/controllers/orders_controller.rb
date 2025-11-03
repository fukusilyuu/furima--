class OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[index create]
  before_action :set_order, only: %i[index create show]
  require 'payjp'
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order = OrderAddress.new
    return if @item.order.nil?

    redirect_to root_path
  end

  def create
    @order = OrderAddress.new(order_params)
    if @order.valid?
      pay_order
      @order.save
      redirect_to root_path
    else
      @item = @order.item
      @orders = @item.orders
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render 'index', status: :unprocessable_entity
    end
  end

  def show
    @exchange = Exchange.new
    @exchanges = @order.exchanges.includes(:user)
  end

  private

  def set_order
    @item = Item.find(params[:id])
    @order = Order.find(params[:id])
    # return unless @item.user.id == current_user.id || @order.item.user.id == current_user.id

    # redirect_to root_path
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_order
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
