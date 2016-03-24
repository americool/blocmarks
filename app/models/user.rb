class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :topics
  has_many :bookmarks
  has_many :likes, dependent: :destroy
  #after_create :send_confirmation

  #private

  #def send_confirmation
  #  self.send_confirmation_instructions
  #end
  def liked(bookmark)
    likes.where(bookmark_id: bookmark.id).first
  end
end
