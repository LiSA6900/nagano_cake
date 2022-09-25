class Public::ItemsController < ApplicationController
   before_action :authenticate_customer!, except: [:index, :show, :search]

  def index
    @items = Item.all.order(id:"DESC").page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

  def search
    @items = Item.search(params[:search]).order(id:"DESC").page(params[:page]).per(8)
    @genres = Genre.all
    render :index
  end


end
