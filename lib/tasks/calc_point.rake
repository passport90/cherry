namespace :calc_point do
  task all: :environment do
    ActiveRecord::Base.logger = Logger.new STDOUT

    songs = Song.unscoped.select(:id).all
    calculate_point_of_songs(songs)
  end

  task missing: :environment do
    ActiveRecord::Base.logger = Logger.new STDOUT

    songs = Song.unscoped.left_joins(:stat_date)
                .where(stat_dates: { point: nil }).select(:id)

    calculate_point_of_songs(songs)
  end
end

def calculate_point_of_songs(songs)
  starting = Time.now

  songs.each do |song|
    entries = Entry.unscoped.where(song: song).order(:year).order(:week)
                   .select(:year, :week, :position).load
    next if entries.empty?

    point_sum = 0
    entries.each do |entry|
      point = 11 - entry.position
      point_sum += point
    end

    StatDate.create(song: song) if song.stat_date.nil?
    song.stat_date.point = point_sum
    song.stat_date.save!
  end

  ending = Time.now
  puts "Elapsed time: #{ending - starting} seconds"
  puts "Calculated point for #{songs.size} songs"
end
