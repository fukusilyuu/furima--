class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      @item = @user.item
      @users = @item.user
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @items = Item.all
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(%i[nickname firstname_kanji lastname_kanji firstname_katakana
                                    lastname_katakana birth_date])
  end
end
