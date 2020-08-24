namespace :calc_median do
  task all: :environment do
    ActiveRecord::Base.logger = Logger.new STDOUT

    songs = Song.unscoped.select(:id).all
    calculate_median_of_songs(songs)
  end

  task missing: :environment do
    ActiveRecord::Base.logger = Logger.new STDOUT

    songs = Song.unscoped.left_joins(:stat_date)
                .where(stat_dates: { median_year: nil }).select(:id)

    calculate_median_of_songs(songs)
  end

  task :missing_and_since, [:since] => :environment do |t, args|
    if args[:since].nil?
      puts 'Please specify year.'
      exit
    end

    ActiveRecord::Base.logger = Logger.new STDOUT

    songs = Song.unscoped.left_joins(:stat_date)
                .where(
                  '"stat_dates"."median_year" IS NULL or '\
                  '"stat_dates"."median_year" >= ?',
                  args[:since]
                ).select(:id)

    calculate_median_of_songs(songs)
  end

  task :missing_and_latest, [:latest] => :environment do |t, args|
    if args[:latest].nil?
      puts 'Please specify year.'
      exit
    end

    ActiveRecord::Base.logger = Logger.new STDOUT

    songs = Song.unscoped.left_joins(:stat_date)
                .where(
                  '"stat_dates"."median_year" IS NULL or '\
                  '"stat_dates"."median_year" <= ?',
                  args[:latest]
                ).select(:id)

    calculate_median_of_songs(songs)
  end
end

def calculate_median_of_songs(songs)
  starting = Time.now

  songs.each do |song|
    entries = Entry.unscoped.where(song: song).order(:year).order(:week)
                    .select(:year, :week, :position).load
    next if entries.empty?

    w_entries = []
    entries.each do |entry|
      weight = 11 - entry.position
      weight.times { w_entries << entry }
    end
    median_entry = w_entries[w_entries.size / 2]

    StatDate.create(song: song) if song.stat_date.nil?
    song.stat_date.median_year = median_entry.year
    song.stat_date.median_week = median_entry.week
    song.stat_date.save!
  end

  ending = Time.now
  puts "Elapsed time: #{ending - starting} seconds"
  puts "Calculated median for #{songs.size} songs"
end
