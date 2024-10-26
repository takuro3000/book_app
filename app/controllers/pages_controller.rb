class PagesController < ApplicationController
  def home
    @books_post = Book.order_by_post_count
    @books_new = Book.latest
  end

  def about
  end
end
