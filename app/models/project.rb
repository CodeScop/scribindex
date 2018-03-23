class Project < ApplicationRecord
  belongs_to :user
	has_many :characters
  has_many :groups
	has_many :stories
	has_many :scenes, through: :stories
	has_many :notes, as: :notable, dependent: :destroy
end
