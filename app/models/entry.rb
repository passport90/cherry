class Entry < ApplicationRecord
  belongs_to :song
  default_scope { order(:year).order(:week).order(:position) }
end
