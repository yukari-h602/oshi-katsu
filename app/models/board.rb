class Board < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :board_tags, dependent: :destroy
  has_many :tags, through: :board_tags

  validates :name, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :world, presence: true, length: { maximum: 65_535 }
  validates :charm, presence: true, length: { maximum: 65_535 }
  validates :body, presence: true, length: { maximum: 65_535 }

  scope :with_tag, ->(tag_name) { joins(:tags).where(tags: { name: tag_name }) }

  def self.ransackable_attributes(auth_object = nil)
    %w[name title world charm body]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[comments user]
  end

  def save_tags(tag_names:)
    ActiveRecord::Base.transaction do
      self.tags = tag_names.map { |name| Tag.find_or_initialize_by(name: name.strip) }
      save!
    end
    true
  rescue StandardError
    false
  end

  def tag_names
    # NOTE: pluckだと新規作成失敗時に値が残らない(返り値がnilになる)
    tags.map(&:name).join(',')
  end
end
