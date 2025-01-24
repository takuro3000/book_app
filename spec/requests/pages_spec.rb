require 'rails_helper'

RSpec.describe "Pages", type: :request do
  let!(:book) { create(:book) }

  describe "GET root" do
    it "ホームページが正常に表示される" do
      # GETリクエストをシミュレート
      get root_path

      # ステータスコード200(成功)を期待する
      expect(response).to have_http_status(200)

      # ページ内に本のタイトルが含まれていることを確認
      expect(response.body).to include(book.title)
    end
  end

  describe "GET /about" do
    before { get about_path }
    it "ステータスコード200を返す" do
      expect(response).to have_http_status(200)
    end
    it "Aboutページを正しくレンダリングする" do
      expect(response.body).to include("TechBook Finder")
    end
  end

  describe "GET /privacy_policy" do
    before { get privacy_policy_path }
    it "ステータスコード200を返す" do
      expect(response).to have_http_status(200)
    end
    it "プライバシーポリシーページを正しくレンダリングする" do
      expect(response.body).to include("プライバシーポリシー")
    end
  end

  describe "GET /terms" do
    before { get terms_path }
    it "ステータスコード200を返す" do
      expect(response).to have_http_status(200)
    end
    it "利用規約ページを正しくレンダリングする" do
      expect(response.body).to include("利用規約")
    end
  end
end
