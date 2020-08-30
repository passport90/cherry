class Song < ApplicationRecord
  extend Memoist
  has_and_belongs_to_many :artists
  has_many :entries
  has_one :stat_date
  default_scope { includes(:artists) }

  scope :order_by_median, -> do
    includes(:stat_date).order('"stat_dates"."median_year", '\
                               '"stat_dates"."median_week", '\
                               '"songs"."title"')
  end

  scope :order_by_median_desc, -> do
    includes(:stat_date).order('"stat_dates"."median_year" DESC, '\
                               '"stat_dates"."median_week" DESC, '\
                               '"songs"."title"')
  end
  
  nilify_blanks

  def display
    "\"#{title}\" - #{artists.pluck(:name).to_sentence}"
  end

  def display_entry_option
    "#{title} - #{artists.pluck(:name).to_sentence}"
  end

  def display_artist
    artists.pluck(:name).to_sentence
  end

  def display_symbol?
    fondness != 0 || is_acclaimed
  end

  def display_fondness
    if fondness < 0
      '👎'
    elsif fondness == 1
      '👍'
    elsif fondness > 1
      '❤️'
    end
  end

  def display_rating
    return 'N/A' if rating.nil?
    '%.2f' % rating
  end

  def rating_color
    if rating.nil?
      'gray'
    elsif rating < 2
      'red'
    elsif rating < 3
      'yellow'
    else
      'green'
    end
  end

  def peak_entry
    Entry.unscoped.where(song: self).order(:position).order(:year)
            .order(:week).first
  end
  memoize :peak_entry

  def median_date
    Date.strptime(
      stat_date.median_year.to_s + stat_date.median_week.to_s.rjust(2, '0'),
      '%G%V'
    ) + 3.days
  end
end
