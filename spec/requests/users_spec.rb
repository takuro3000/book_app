require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:book) { create(:book) }

  before do
    sign_in user
  end

  describe "GET /users/:id" do
    context "存在するユーザーの場合" do
      before do
        create(:post, user: user, book: book)
        get user_path(user)
      end

      it "ステータスコード200を返す" do
        expect(response).to have_http_status(200)
      end

      it "showページを正しくレンダリングする" do
        expect(response.body).to include(user.name)
        expect(response.body).to include(user.self_introduction)
      end

      it "ユーザーの書籍が表示されている" do
        get user_path(user)
        expect(response.body).to include(book.title)
      end
    end
  end

  describe "GET /users/:id/edit" do
    context "自分のプロフィールを編集する場合" do
      before do
        get edit_user_path(user)
      end

      it "ステータスコード200を返す" do
        expect(response).to have_http_status(200)
      end

      it "editページを正しくレンダリングする" do
        expect(response.body).to include("編集")
      end
    end

    context "他人のプロフィールを編集しようとした場合" do
      before do
        get edit_user_path(other_user)
      end

      it "リダイレクトされ、権限エラーメッセージが表示される" do
        expect(response).to redirect_to(user_path(user))
        follow_redirect!
        expect(response.body).to include("このプロフィールを編集する権限がありません。")
      end
    end

    context "未認証ユーザーがアクセスした場合" do
      before do
        sign_out user
        get edit_user_path(user)
      end

      it "ログインページにリダイレクトされる" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PATCH /users/:id" do
    context "有効なパラメータの場合" do
      let(:valid_params) { { user: { name: "Updated Name", self_introduction: "Updated Introduction" } } }

      it "ユーザー情報を更新し、リダイレクトする" do
        patch user_path(user), params: valid_params
        expect(response).to redirect_to(user_path(user))
        user.reload
        expect(user.name).to eq("Updated Name")
        expect(user.self_introduction).to eq("Updated Introduction")
      end
    end

    context "無効なパラメータの場合" do
      let(:invalid_params) { { user: { name: "", self_introduction: "A" * 201 } } }

      it "ユーザー情報を更新せず、editページを再レンダリングする" do
        patch user_path(user), params: invalid_params
        expect(response).to have_http_status(200) # 200 OKで再レンダリング
        expect(user.name).not_to eq("")
        expect(user.self_introduction.length).not_to eq(201)
      end
    end

    context "他人のユーザー情報を更新しようとした場合" do
      let(:update_params) { { user: { name: "Hacked Name" } } }

      it "リダイレクトされ、権限エラーメッセージが表示される" do
        patch user_path(other_user), params: update_params
        expect(response).to redirect_to(user_path(user))
        follow_redirect!
        expect(response.body).to include("このプロフィールを編集する権限がありません。")
        other_user.reload
        expect(other_user.name).not_to eq("Hacked Name")
      end
    end

    context "未認証ユーザーが更新を試みた場合" do
      let(:update_params) { { user: { name: "Hacked Name" } } }

      before do
        sign_out user
        patch user_path(user), params: update_params
      end

      it "ログインページにリダイレクトされる" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
