class BoardTag < ApplicationRecord
  belongs_to :board
  belongs_to :tag

  validates :tag_id, uniqueness: { scope: :board_id }
end
