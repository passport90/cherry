task migrate_stream_link: :environment do
  ActiveRecord::Base.logger = Logger.new STDOUT
  songs = Song.unscoped.all
  songs.each do |song|
    next unless song.stream_link.present?

    match = song.stream_link.match(/id\/album\/.+\/(.+)\">/)
    next unless match

    song.update!(stream_apple_music_id: match[1])
  end
end
