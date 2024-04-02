class Label < ApplicationRecord
    has_many :tasks, through: :labellings
    has_many :labellings, dependent: :destroy
end
