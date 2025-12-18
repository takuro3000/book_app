class PagesController < ApplicationController
  def home
    @books_popular = fetch_books_by_difficulty(0, 5)
    @books_beginner = fetch_books_by_difficulty(1, 3)
    @books_intermediate = fetch_books_by_difficulty(2, 4)
    @books_advanced = fetch_books_by_difficulty(3, 5)
    @books_new = Book.latest.top_ranked
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
