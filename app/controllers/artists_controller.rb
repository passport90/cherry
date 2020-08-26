class ArtistsController < ApplicationController
  def create
    @artist = Artist.create!(artist_params)
    redirect_to artist_path(@artist)
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def index
    items_per_page = 60
    @page = params.fetch(:page, 0).to_i
    @page_count = (Artist.count.to_f / items_per_page).ceil
    @artists = Artist.select(:id, :name).order(:name)
                     .offset(@page * items_per_page).limit(items_per_page)
                     .all
  end

  def new
    @artist = Artist.new
  end

  def show
    @artist = Artist.find(params[:id])
    items_per_page = 50
    @page = params.fetch(:page, 0).to_i
    @page_count = (@artist.songs.count.to_f / items_per_page).ceil
    @songs = @artist.songs.order_by_median_desc
                 .offset(@page * items_per_page).limit(items_per_page)
                 .all
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
