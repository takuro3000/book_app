// app/javascript/controllers/show_book_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // ここに書いた処理は、コントローラがアタッチされたタイミングで毎回実行される
    console.log("show_book_controller connected!!")

    // 以下、もともと show_book.js に書いていた処理をペーストする
    const userPosts = document.querySelectorAll('.user-post-content'); // 全てのユーザー投稿を取得
    userPosts.forEach(postElement => {
        const maxAllowedHeight = 96; // 約4行分の高さ
        if (postElement.scrollHeight > maxAllowedHeight) {
            const postElementId = postElement.id.split('_')[2];
            const showMoreBtn = document.getElementById('showMoreBtn_' + postElementId);
            if (showMoreBtn) {
                showMoreBtn.style.display = "inline"; // 「もっと見る」ボタンを表示
                postElement.style.maxHeight = maxAllowedHeight + "px";
                postElement.style.overflow = "hidden";

                // 「もっと見る」ボタンのクリックイベント
                showMoreBtn.addEventListener("click", () => {
                    if (postElement.classList.contains('expanded')) {
                        postElement.classList.remove('expanded');
                        postElement.style.maxHeight = maxAllowedHeight + "px";
                        showMoreBtn.textContent = "続きを読む";
                    } else {
                        postElement.classList.add('expanded');
                        postElement.style.maxHeight = "none";
                        showMoreBtn.textContent = "閉じる";
                    }
                });
            }
        }
    });

    // ユーザー以外の投稿の高さを確認
    const posts = document.querySelectorAll('.post-content');
    posts.forEach(post => {
        const maxHeight = 96; // 約4行分の高さ
        if (post.scrollHeight > maxHeight) {
            const postId = post.id.split('_')[1];
            const readMoreBtn = document.getElementById('readMoreBtn_' + postId);

            if (readMoreBtn) {
                readMoreBtn.style.display = "inline";
                post.style.maxHeight = maxHeight + "px";
                post.style.overflow = "hidden";

                readMoreBtn.addEventListener("click", () => {
                    if (post.classList.contains('expanded')) {
                        post.classList.remove('expanded');
                        post.style.maxHeight = maxHeight + "px";
                        readMoreBtn.textContent = "続きを読む";
                    } else {
                        post.classList.add('expanded');
                        post.style.maxHeight = "none";
                        readMoreBtn.textContent = "閉じる";
                    }
                });
            }
        }
    });

    // ...
  }
}
