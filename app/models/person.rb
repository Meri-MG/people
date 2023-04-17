class Person < ApplicationRecord
  has_many :children, class_name: 'Person', foreign_key: 'parent_id'
  has_many :grandchildren, through: :children, source: :children
  belongs_to :parent, class_name: 'Person', foreign_key: 'parent_id', optional: true

  validates :name, presence: true
end
