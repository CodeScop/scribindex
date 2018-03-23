class Group < ApplicationRecord
  belongs_to :project
  has_many :notes, as: :notable, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :characters, through: :memberships
end
