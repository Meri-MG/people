class Person < ApplicationRecord
  belongs_to :parent, class_name: 'Person', foreign_key: 'parent_id', optional: true
  has_many :children, class_name: 'Person', foreign_key: 'parent_id'
  has_many :grandchildren, through: :children, source: :children

  validates :name, presence: true
end
