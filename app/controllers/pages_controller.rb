class PagesController < ApplicationController
  def home
    @books = Book.order_by_post_count
  end

  def about
  end
end
