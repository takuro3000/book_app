require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is invalid without a name" do
      user.name = nil
      expect(user).not_to be_valid
    end

    it "is invalid if the name is longer than 100 characters" do
      user.name = "a" * 101
      expect(user).not_to be_valid
    end

    it "is invalid if the self_introduction is longer than 200 characters" do
      user.self_introduction = "a" * 201
      expect(user).not_to be_valid
    end

    it "is invalid if the level is not included in the specified list" do
      user.level = "エキスパートエンジニア"
      expect(user).not_to be_valid
    end
  end

  describe "Callbacks" do
    it "generates a unique custom_id before creation" do
      user.save
      expect(user.custom_id).to be_present
      expect(user.custom_id.length).to eq(6)
    end
  end

  describe "#already_liked?" do
    let(:post) { create(:post, user: user) }

    it "returns true if the user has already liked the post" do
      user.likes.create(post: post)
      expect(user.already_liked?(post)).to be true
    end

    it "returns false if the user has not liked the post" do
      expect(user.already_liked?(post)).to be false
    end
  end
end
