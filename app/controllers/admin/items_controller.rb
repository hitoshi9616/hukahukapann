class Admin::ItemsController < ApplicationController

  before_action :authenticate_admin!

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    if item.save
      redirect_to admin_item_path(item.id)
    else
      @item = Item.new
      render :new
    end
  end

  def index
    @items = Item.all.order('updated_at DESC')
  end

  def show
    @item = Item.find(params[:id])
    @reviews = Review.where(item_id: @item.id).order('updated_at DESC')
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to admin_item_path(item.id)
    else
      @item = Item.find(params[:id])
      render :edit
    end
  end

  def confirm
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image)
  end

end
