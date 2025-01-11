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
end
