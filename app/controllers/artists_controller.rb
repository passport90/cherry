class ArtistsController < ApplicationController
  def create
    Artist.create!(artist_params)
    redirect_to artists_path
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def index
    @artists = Artist.all
  end

  def new
    @artist = Artist.new
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    @artist.update!(artist_params)
    redirect_to artist_path(@artist)
  end

private
  def artist_params
    params.require(:artist).permit(:name)
  end
end
