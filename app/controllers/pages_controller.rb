class PagesController < ApplicationController
  def home
    @most_reviewed_books = Book.most_reviewed
    @beginner_books = Book.by_difficulty_range(1, 3)
    @intermediate_books = Book.by_difficulty_range(2, 4)
    @advanced_books = Book.by_difficulty_range(3, 5)
    @latest_books = Book.latest
  end

  def about
  end

  def privacy_policy
  end

  def terms
  end
end
