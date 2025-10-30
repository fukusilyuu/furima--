class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

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
    @items = Item.all
    @users = User.all
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(%i[nickname firstname_kanji lastname_kanji firstname_katakana
                                    lastname_katakana birth_date])
  end

  def set_user
    @user = User.find(params[:id])
  end
end
