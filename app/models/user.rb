class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise authentication_keys: [:custom_id]
  before_create :generate_custom_id
  after_create :send_custom_id_email
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :icon
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  private

  def generate_custom_id
    loop do
      self.custom_id = SecureRandom.random_number(100000..999999).to_s
      break unless User.exists?(custom_id: custom_id)
    end
  end

  def send_custom_id_email
    UserMailer.send_custom_id(self).deliver_now
  end
end
