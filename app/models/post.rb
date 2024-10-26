class Post < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :likes, dependent: :destroy

  validates_uniqueness_of :book_id, scope: :user_id
end
