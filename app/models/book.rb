class Book < ApplicationRecord
  has_one_attached :image
  has_many :posts, dependent: :destroy

  scope :latest, -> { order(published_day: :desc) }
  scope :order_by_post_count, -> do
    sql = <<~SQL
      LEFT OUTER JOIN (
        SELECT c.book_id, COUNT(*) AS cnt
        FROM posts c 
        GROUP BY c.book_id
      ) post_counts
      ON post_counts.book_id = books.id
    SQL
    joins(sql)
    .select('DISTINCT books.*')
    .order(Arel.sql("COALESCE(post_counts.cnt, 0) DESC"))
  end

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

  # ransack用の検索対象フィールドを指定する
  def self.searchable_attributes
    %w[title author category published_day posts_count]
  end
  searchable_attributes.each do |field|
    scope "search_by_#{field}", ->(keyword) { where("#{field} LIKE ?", "%#{keyword}%") }
  end
  
  def self.ransackable_attributes(auth_object = nil)
   ["title","author","category","published_day","posts_count"] # 検索可能な属性名を指定
  end

  def self.ransackable_associations(auth_object = nil)
    ["posts"] # 検索可能な関連名を指定
  end
end
