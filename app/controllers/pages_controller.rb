class PagesController < ApplicationController
  def home
    @most_reviewed_books = Book.for_home_by_difficulty(0, 5)
    @beginner_books = Book.for_home_by_difficulty(1, 3)
    @intermediate_books = Book.for_home_by_difficulty(2, 4)
    @advanced_books = Book.for_home_by_difficulty(3, 5)
    @latest_books = Book.latest
  end

  def about
  end

  def privacy_policy
  end

  def terms
  end
end
