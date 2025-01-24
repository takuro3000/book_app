require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:post) { build(:post, user: user, book: book) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(post).to be_valid
    end

    it "is invalid without a user" do
      post.user = nil
      expect(post).not_to be_valid
    end

    it "is invalid without a book" do
      post.book = nil
      expect(post).not_to be_valid
    end

    it "is invalid with a duplicate book_id scoped to the same user_id" do
      post.save
      duplicate_post = build(:post, user: user, book: book)
      expect(duplicate_post).not_to be_valid
    end

    it "is invalid without a difficulty" do
      post.difficulty = nil
      expect(post).not_to be_valid
    end

    it "is invalid with a non-integer difficulty" do
      post.difficulty = 3.5
      expect(post).not_to be_valid
    end

    it "is invalid with a difficulty less than or equal to 0" do
      post.difficulty = 0
      expect(post).not_to be_valid
    end

    it "is invalid with a difficulty greater than or equal to 6" do
      post.difficulty = 6
      expect(post).not_to be_valid
    end

    it "is invalid with content longer than 500 characters" do
      post.content = "a" * 501
      expect(post).not_to be_valid
    end
  end
end
