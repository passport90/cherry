task migrate_video_link: :environment do
  ActiveRecord::Base.logger = Logger.new STDOUT
  songs = Song.unscoped.all
  songs.each do |song|
    next unless song.video_link.present?

    if song.video_link[0] == '<'
      start_pos = '<iframe width="560" height="315" src="https://www.youtube.com/embed/'.size
      end_pos = '" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'.size
      youtube_id = song.video_link[start_pos...-end_pos]
    end

    song.update!(video_youtube_id: youtube_id)
  end
end
