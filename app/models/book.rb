class Book < ApplicationRecord
  has_one_attached :image
  has_many :posts, dependent: :destroy

  validate :image_presence

  scope :latest, -> { order(published_day: :desc).limit(12) }
  scope :with_average_difficulty_between, ->(min, max) {
    joins(:posts)
      .select('books.*, AVG(posts.difficulty) AS average_difficulty, COUNT(posts.id) AS posts_count')
      .group('books.id')
      .having('AVG(posts.difficulty) BETWEEN ? AND ?', min, max)
  }

  scope :ordered_by_posts_count, -> {
    order('posts_count DESC')
  }

  scope :top_ranked, ->(limit = 12) {
    limit(limit)
  }

  def avg_difficulty
    unless self.posts.empty?
      posts.average(:difficulty).round(1).to_f
    else
      0.0
    end
  end

  def post_difficulty_percentage
    unless self.posts.empty?
      posts.average(:difficulty).round(1).to_f*100/5
    else
      0.0
    end
  end

  ransacker :posts_count do
    Arel.sql('(
      SELECT COUNT(posts.id) FROM posts WHERE posts.book_id = books.id
    )')
  end

  ransacker :avg_difficulty, type: :float do
    Arel.sql('(
      SELECT COALESCE(ROUND(AVG(posts.difficulty), 1), 0)
      FROM posts
      WHERE posts.book_id = books.id
    )')
  end

  # ransack用の検索対象フィールドを指定する
  def self.searchable_attributes
    %w[title author category published_day posts_count avg_difficulty]
  end
  searchable_attributes.each do |field|
    scope "search_by_#{field}", ->(keyword) { where("#{field} LIKE ?", "%#{keyword}%") }
  end
  
  def self.ransackable_attributes(auth_object = nil)
   ["title","author","category","published_day","posts_count","avg_difficulty"] # 検索可能な属性名を指定
  end

  def self.ransackable_associations(auth_object = nil)
    ["posts"] # 検索可能な関連名を指定
  end

  private

  def image_presence
    errors.add(:image, "を添付してください") unless image.attached?
  end
end
