class PagesController < ApplicationController
  def home
    @most_reviewed_books = Book.with_average_difficulty_between(0, 5)
      .ordered_by_posts_count
      .limit_for_home
    @beginner_books = Book.with_average_difficulty_between(1, 3)
      .ordered_by_posts_count
      .limit_for_home
    @intermediate_books = Book.with_average_difficulty_between(2, 4)
      .ordered_by_posts_count
      .limit_for_home
    @advanced_books = Book.with_average_difficulty_between(3, 5)
      .ordered_by_posts_count
      .limit_for_home
    @latest_books = Book.latest.limit_for_home
  end

  def about
  end

  def privacy_policy
  end

  def terms
  end
end
