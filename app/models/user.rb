class User < ApplicationRecord
  authenticates_with_sorcery!

	mount_uploader :avatar, AvatarUploader

	has_many :boards, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :bookmarks, dependent: :destroy
	has_many :bookmark_boards, through: :bookmarks, source: :board
	has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
	has_many :followings, through: :relationships, source: :followed
	has_many :followers, through: :reverse_of_relationships, source: :follower
	has_many :posts, dependent: :destroy

	validates :password, length: { minimum: 3}, if: -> { new_record? || chaneges[:crypted_password] },on: :create
	validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
	validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
	
	validates :email, uniqueness: true, presence: true
	validates :name, presence: true, length: { maximum: 255 }

	def own?(object)
    id == object.user_id
  end

	def bookmark(board)
		bookmark_boards << board
	end

	def unbookmark(board)
		bookmark_boards.destroy(board)
	end

	def bookmark?(board)
		bookmark_boards.include?(board)
	end

	# フォローしたときの処理
	def follow(user_id)
		relationships.create(followed_id: user_id)
	end
	# フォローを外すときの処理
	def unfollow(user_id)
		relationships.find_by(followed_id: user_id).destroy
	end
	# フォローしているか判定
	def following?(user)
		followings.include?(user)
	end
end
