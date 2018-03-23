class Story < ApplicationRecord
  belongs_to :project
  has_many :scenes
  has_many :notes, as: :notable, dependent: :destroy
end
