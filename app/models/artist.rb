class Artist < ApplicationRecord
    default_scope { order(name: :asc) }
end
