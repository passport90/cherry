class SongsController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      @song = Song.create(song_params)
      if params[:song][:artist_id].blank?
        raise ActionController::ParameterMissing
      end
      @song.artist_ids = params[:song][:artist_id]
    end
    redirect_to song_path(@song)
  end

  def edit
    @song = Song.find(params[:id])
  end

  def index
    @songs = Song.all
  end

  def new
    @song = Song.new
  end

  def show
    @song = Song.find(params[:id])
  end

  def update
    ActiveRecord::Base.transaction do
      @song = Song.find(params[:id])
      @song.update(song_params)
      if params[:song][:artist_id].blank?
        raise ActionController::ParameterMissing
      end
      @song.artist_ids = params[:song][:artist_id]
    end

    redirect_to song_path(@song)
  end

private
  def song_params
    params.require(:song)
          .permit(:title, :is_liked, :stream_link, :video_link, :rating)
  end
end
