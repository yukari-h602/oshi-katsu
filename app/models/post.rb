class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :twitter, presence: true, length: { maximum: 255 }

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id title twitter updated_at user_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end
end
