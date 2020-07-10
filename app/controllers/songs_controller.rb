class SongsController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      @song = Song.new(song_params)
      @song.artist_ids = params[:song][:artist_id]
      raise ActionController::ParameterMissing if @song.artist_ids.blank?

      @song.save

      redirect_to song_path(@song)
    end
  end

  def index
    @songs = Song.all
  end

  def new
    @song = Song.new
    @artists = Artist.all
  end

  def show
    @song = Song.find(params[:id])
  end

private
  def song_params
    params.require(:song).permit(:title, :artist_id)
  end
end
