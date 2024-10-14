class Book < ApplicationRecord
  has_one_attached :image
  has_many :posts, dependent: :destroy

  def avg_difficulty
    unless self.posts.empty?
      posts.average(:difficulty).round(1).to_f
    else
      0.0
    end
  end
end
