class PagesController < ApplicationController
  def home
    @books_post = Book.order_by_post_count.limit(12)
    @books_new = Book.latest.limit(12)
  end

  def about
  end

  def privacy_policy
  end

  def terms
  end
end
