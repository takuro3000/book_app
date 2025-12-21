// app/javascript/controllers/show_book_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // ユーザー以外の投稿の高さを確認
    const posts = document.querySelectorAll('.post-content');
    posts.forEach(post => {
        const maxHeight = 100; // 約4行分の高さ
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
