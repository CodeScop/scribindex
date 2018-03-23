class Scene < ApplicationRecord
  belongs_to :story
  has_many :notes, as: :notable, dependent: :destroy
  include RailsSortable::Model
  set_sortable :position
end
