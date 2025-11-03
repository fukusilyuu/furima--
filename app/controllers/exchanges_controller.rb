class ExchangesController < ApplicationController
  before_action :set_order, only: %i[create destroy]

  def create
    @exchange = @order.exchanges.build(exchange_params)
    @exchange.user = current_user
    if @exchange.save
      redirect_to item_order_path(@order.item, @order)
    else
      render 'orders/show'
    end
  end

  def destroy
    @exchange = @order.exchanges.find(params[:id])
    if @exchange.user == current_user
      @exchange.destroy
      redirect_to @order, notice: 'メッセージを削除しました'
    else
      render 'orders/show', status: :unprocessable_entity

    end
  end

  private

  def exchange_params
    params.require(:exchange).permit(:message).merge(user_id: current_user.id, item_id: params[:item_id],
                                                     order_id: params[:order_id])
  end

  def set_order
    @order = Order.new
    @order = Order.find(params[:order_id])
  end
end
