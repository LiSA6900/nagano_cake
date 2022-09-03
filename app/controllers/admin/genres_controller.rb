class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  def edit
  end

  private

  def genre_params
    params.require(:genre).parmit(:name)
  end
end

