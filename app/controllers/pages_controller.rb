class PagesController < ApplicationController
  def home
    @most_reviewed_books = fetch_books_by_difficulty(0, 5)
    @beginner_books = fetch_books_by_difficulty(1, 3)
    @intermediate_books = fetch_books_by_difficulty(2, 4)
    @advanced_books = fetch_books_by_difficulty(3, 5)
    @latest_books = Book.latest
  end

  def about
  end

  def privacy_policy
  end

  def terms
  end

  private

  def fetch_books_by_difficulty(min_difficulty, max_difficulty)
    Book.with_average_difficulty_between(min_difficulty, max_difficulty)
      .ordered_by_posts_count
      .top_ranked
  end
end
