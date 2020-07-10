class Song < ApplicationRecord
  has_and_belongs_to_many :artists
  has_many :entries
  default_scope { includes(:artists).order(:title) }

  def display
    "\"#{title}\" - #{artists.pluck(:name).to_sentence}"
  end

  def display_artist
    artists.pluck(:name).to_sentence
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
end
