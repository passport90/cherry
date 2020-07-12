class Song < ApplicationRecord
  extend Memoist
  has_and_belongs_to_many :artists
  has_many :entries
  default_scope { includes(:artists).order(:title) }

  def display
    "\"#{title}\" - #{artists.pluck(:name).to_sentence}"
  end

  def display_entry_option
    "#{title} - #{artists.pluck(:name).to_sentence}"
  end

  def display_artist
    artists.pluck(:name).to_sentence
  end

  def display_fondness
    if fondness < 0
      '👎'
    elsif fondness == 1
      '👍'
    elsif fondness > 1
      '😍'
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
    entries.unscoped.where(song: self).order(:position).order(:year)
            .order(:week).first
  end
  memoize :peak_entry
end
