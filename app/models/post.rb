class Post < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :likes, dependent: :destroy

  validates :book_id, uniqueness: { scope: :user_id }

  validates :difficulty,
            presence: true,
            numericality: { only_integer: true, greater_than: 0, less_than: 6 }

  validates :content, length: { maximum: 500 }
end
