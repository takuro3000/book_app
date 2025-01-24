require 'rails_helper'

RSpec.describe "User::Books", type: :request do
  let(:book) { create(:book) }

  describe "GET /books" do
    before do
      get books_path
    end

    it "ステータスコード200を返す" do
      expect(response).to have_http_status(200)
    end

    it "indexページを正しくレンダリングする" do
      expect(response.body).to include("本を探す")
    end
  end

  describe "GET /books/:id" do
    before do
      get book_path(book)
    end

    it "ステータスコード200を返す" do
      expect(response).to have_http_status(200)
    end

    it "showページを正しくレンダリングする" do
      expect(response.body).to include("難易度")
    end
  end
end
