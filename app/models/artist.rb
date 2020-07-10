class Artist < ApplicationRecord
  has_and_belongs_to_many :songs
  default_scope { order(name: :asc) }
end
