class Song < ApplicationRecord
  has_and_belongs_to_many :artists
  default_scope { includes(:artists).order(:title) }

  def display
    "\"#{title}\" - #{artists.pluck(:name).to_sentence}"
  end
end
