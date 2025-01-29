class PagesController < ApplicationController
  def home
    @books_post = Book
      .with_average_difficulty_between(0, 5)
      .ordered_by_posts_count
      .top_ranked
    @books_new = Book
      .latest
      .top_ranked
    @books_dif_low = Book
      .with_average_difficulty_between(1, 3)
      .ordered_by_posts_count
      .top_ranked
    @books_dif_mid = Book
      .with_average_difficulty_between(2, 4)
      .ordered_by_posts_count
      .top_ranked
    @books_dif_high = Book
      .with_average_difficulty_between(3, 5)
      .ordered_by_posts_count
      .top_ranked
  end

  def about
  end

  def privacy_policy
  end

  def terms
  end
end
