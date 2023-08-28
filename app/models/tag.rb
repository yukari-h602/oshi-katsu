class Tag < ApplicationRecord
  has_many :board_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :boards, through: :board_tags

  validates :name, uniqueness: true, presence: true
end
