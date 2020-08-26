class SongsController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      @song = Song.create!(song_params)
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
    items_per_page = 30
    @page = params.fetch(:page, 0).to_i
    @page_count = (Song.count.to_f / items_per_page).ceil
    @songs = Song.order_by_median_desc
                 .offset(@page * items_per_page).limit(items_per_page)
                 .all
  end

  def new
    @song = Song.new
  end

  def show
    @song = Song.find(params[:id])

    if @song.entries.exists?
      @entrance = @song.entries.first
      @exit = @song.entries.last
      @peak = @song.peak_entry
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @song = Song.find(params[:id])
      @song.update!(song_params)
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
          .permit(
            :title, :fondness, :stream_link, :video_link, :rating, :is_acclaimed
          )
  end
end
