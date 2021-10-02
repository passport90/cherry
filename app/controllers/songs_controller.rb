class SongsController < ApplicationController
  def create
    # Helper for links
    if false && params[:song][:stream_apple_music_id].start_with?('https://')
      match = params[:song][:stream_apple_music_id].match(
        /\/id\/album\/.+\/(.+)$/
      )
      params[:song][:stream_apple_music_id] = match[1]
    end
    if params[:song][:stream_spotify_id].start_with?('https://')
      spotify_prefix_len = 'https://open.spotify.com/track/'.size
      params[:song][:stream_spotify_id] = (
        params[:song][:stream_spotify_id][spotify_prefix_len..-1]
      )
    end
    if params[:song][:video_youtube_id].start_with?('https://')
      youtube_prefix_len = 'https://www.youtube.com/watch?v='.size
      params[:song][:video_youtube_id] = (
        params[:song][:video_youtube_id][youtube_prefix_len..-1]
      )
    end

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
    items_per_page = 50
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
    # Helper for links
    if false && params[:song][:stream_apple_music_id].start_with?('https://')
      match = params[:song][:stream_apple_music_id].match(
        /\/id\/album\/.+\/(.+)$/
      )
      params[:song][:stream_apple_music_id] = match[1]
    end
    if params[:song][:stream_spotify_id].start_with?('https://')
      spotify_prefix_len = 'https://open.spotify.com/track/'.size
      params[:song][:stream_spotify_id] = (
        params[:song][:stream_spotify_id][spotify_prefix_len..-1]
      )
    end
    if params[:song][:video_youtube_id].start_with?('https://')
      youtube_prefix_len = 'https://www.youtube.com/watch?v='.size
      params[:song][:video_youtube_id] = (
        params[:song][:video_youtube_id][youtube_prefix_len..-1]
      )
    end

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
            :title, :stream_apple_music_id, :stream_spotify_id,
            :video_youtube_id
          )
  end
end
