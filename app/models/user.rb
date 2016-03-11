class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :topics 
  #after_create :send_confirmation

  #private

  #def send_confirmation
  #  self.send_confirmation_instructions
  #end

end
