class Board < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :world, presence: true, length: { maximum: 65_535 }
  validates :charm, presence: true, length: { maximum: 65_535 }
  validates :body, presence: true, length: { maximum: 65_535 }

  def self.ransackable_attributes(auth_object = nil)
    %w[name title world charm body]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[comments user]
  end
end
