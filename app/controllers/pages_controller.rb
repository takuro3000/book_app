class PagesController < ApplicationController
  def home
    @books_post = Book.order_by_post_count.limit(12)
    @books_new = Book.latest.limit(12)
    @books_dif_low = Book
      .joins(:posts)
      .select('books.*, AVG(posts.difficulty) AS average_difficulty, COUNT(posts.id) AS posts_count')
      .group('books.id')
      .having('AVG(posts.difficulty) BETWEEN ? AND ?', 1, 3)
      .order('posts_count DESC')
      .limit(8)
    @books_dif_mid = Book
      .joins(:posts)
      .select('books.*, AVG(posts.difficulty) AS average_difficulty, COUNT(posts.id) AS posts_count')
      .group('books.id')
      .having('AVG(posts.difficulty) BETWEEN ? AND ?', 2, 4)
      .order('posts_count DESC')
      .limit(8)
    @books_dif_high = Book
      .joins(:posts)
      .select('books.*, AVG(posts.difficulty) AS average_difficulty, COUNT(posts.id) AS posts_count')
      .group('books.id')
      .having('AVG(posts.difficulty) BETWEEN ? AND ?', 3, 5)
      .order('posts_count DESC')
      .limit(8)
  end

  def about
  end

  def privacy_policy
  end

  def terms
  end
end
