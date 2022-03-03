class ItemsController < ApplicationController

  def index
    if User.exists?(params[:user_id])
      user = User.find(params[:user_id])
      items = user.items
      render json: items, include: :user
    else
      all_items = Item.all
      render json: all_items, include: :user, status: :not_found
    end
  end

  def show
    if Item.exists?(params[:id])
      user = User.find(params[:user_id])
      item = user.items.find(params[:id])
      render json: item, include: :user
    else
      render json: { error: "This item doesn't exist"}, status: :not_found
    end
  end

  def create
    if User.exists?(params[:user_id])
      user = User.find(params[:user_id])
      item = Item.create(item_params)
      user.items << item
      render json: item, include: :user, status: :created
    else
      render json: { error: "This user doesn't exist"}, status: :not_found
    end
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end

end