class Entry < ApplicationRecord
  belongs_to :song
  default_scope { includes(:song).order(:year).order(:week).order(:position) }
end
