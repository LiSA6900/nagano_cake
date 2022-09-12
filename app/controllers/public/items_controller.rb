class Public::ItemsController < ApplicationController
  def index
    @items = Item.all.order(id:"DESC").page(params[:page]).per(8)
    @genres = Genre.all
  end
end
