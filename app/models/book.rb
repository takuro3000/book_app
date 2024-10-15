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

  # ransack用の検索対象フィールドを指定する
  def self.searchable_attributes
    %w[title]
  end
  searchable_attributes.each do |field|
    scope "search_by_#{field}", ->(keyword) { where("#{field} LIKE ?", "%#{keyword}%") }
  end
  
  def self.ransackable_attributes(auth_object = nil)
   ["title"] # 検索可能な属性名を指定
  end
end
