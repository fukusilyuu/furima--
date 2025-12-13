class UsersController < ApplicationController
  before_action :authenticate_user!, expect: %i[index show]
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
    @user = User.find(params[:id])
    current_user.follow(@user)
    @users = User.all
  end

  def edit
    return if @user == current_user

    redirect_to user_path, alert: '権限がありません。'
  end

  def update
    if @user.update(user_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @user.destroy

    redirect_to root_path
  end

  def following
    @user = User.find(params[:id])
    @following_users = @user.following
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
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
