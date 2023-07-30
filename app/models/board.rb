class Board < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :world, presence: true, length: { maximum: 65_535 }
  validates :charm, presence: true, length: { maximum: 65_535 }
  validates :body, presence: true, length: { maximum: 65_535 }
end
