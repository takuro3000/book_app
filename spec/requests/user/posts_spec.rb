require 'rails_helper'

RSpec.describe "User::Posts", type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:post_record) { create(:post, user: user, book: book) }

  # ユーザーをログインさせる
  before do
    sign_in user
  end

  describe "GET /books/:book_id/posts/new" do
    before do
      get new_book_post_path(book)
    end
    it "ステータスコード200を返す" do
      expect(response).to have_http_status(200)
    end
    it "newページを正しくレンダリングする" do
      expect(response.body).to include("レビューの投稿")
    end
  end

  describe "POST /books/:book_id/posts" do
    context "有効なパラメータの場合" do
      let(:valid_params) { { post: { difficulty: 4, content: "有効な投稿内容" } } }
      it "新しい投稿を作成し、リダイレクトする" do
        expect do
          post book_posts_path(book), params: valid_params
        end.to change(Post, :count).by(1)
        expect(response).to redirect_to(book_path(book))
      end
    end
    context "無効なパラメータの場合" do
      let(:invalid_params) { { post: { difficulty: 6, content: "" } } }
      it "投稿を作成せず、新しいページを再レンダリングする" do
        expect do
          post book_posts_path(book), params: invalid_params
        end.not_to change(Post, :count)
        expect(response.body).to include("レビューの投稿")
      end
    end
  end

  describe "GET /books/:book_id/posts/:id/edit" do
    before do
      get edit_book_post_path(book, post_record)
    end
    it "ステータスコード200を返す" do
      expect(response).to have_http_status(200)
    end
    it "editページを正しくレンダリングする" do
      expect(response.body).to include("レビューの編集")
    end
    context "他のユーザーの投稿を編集しようとした場合" do
      let(:other_user) { create(:user) }
      let(:other_post) { create(:post, user: other_user, book: book) }
      before do
        get edit_book_post_path(book, other_post)
      end
      it "リダイレクトされ、権限エラーメッセージが表示される" do
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include("この投稿を編集する権限がありません。")
      end
    end
  end

  describe "PATCH /books/:book_id/posts/:id" do
    context "有効なパラメータの場合" do
      let(:valid_update_params) { { post: { difficulty: 5, content: "更新された内容" } } }
      it "投稿を更新し、リダイレクトする" do
        patch book_post_path(book, post_record), params: valid_update_params
        expect(response).to redirect_to(book_path(book))
        post_record.reload
        expect(post_record.difficulty).to eq(5)
        expect(post_record.content).to eq("更新された内容")
      end
    end
    context "無効なパラメータの場合" do
      let(:invalid_update_params) { { post: { difficulty: 0, content: "" } } }
      it "投稿を更新せず、editページを再レンダリングする" do
        patch book_post_path(book, post_record), params: invalid_update_params
        post_record.reload
        expect(post_record.difficulty).not_to eq(0)
        expect(post_record.content).not_to eq("")
      end
    end
    context "他のユーザーの投稿を更新しようとした場合" do
      let(:other_user) { create(:user) }
      let(:other_post) { create(:post, user: other_user, book: book) }
      let(:update_params) { { post: { difficulty: 2, content: "不正な更新" } } }
      it "リダイレクトされ、権限エラーメッセージが表示される" do
        patch book_post_path(book, other_post), params: update_params
        follow_redirect!
        expect(response.body).to include("この投稿を編集する権限がありません。")
        other_post.reload
        expect(other_post.difficulty).not_to eq(2)
        expect(other_post.content).not_to eq("不正な更新")
      end
    end
  end
end
