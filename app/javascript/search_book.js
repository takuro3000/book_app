document.getElementById('book_title').addEventListener('keydown', function(event) {
  // Enterキーが押されたらフォーム送信を無効化する
  if (event.key === 'Enter') {
    event.preventDefault();  // デフォルトのフォーム送信を防ぐ
  }
});

document.getElementById('search_button').addEventListener('click', function(event) {
  // デフォルトのフォーム送信を防ぐ
  event.preventDefault();

  // 検索フィールドから本のタイトルを取得
  const title = document.getElementById('book_title').value;

  // Google Books APIにリクエストを送信
  fetch(`/admin/books/search?title=${encodeURIComponent(title)}`)
    .then(response => response.json())
    .then(data => {
      if (data.error) {
        alert('本が見つかりませんでした。');
      } else {
        // 取得したデータをフォームに反映（データベースにはまだ保存されない）
        document.getElementById('book_author').value = data.authors;
        document.getElementById('book_description').value = data.description;
        document.getElementById('book_published_day').value = data.published_date;
        document.getElementById('book_volume').value = data.volume;
        if (data.language === 'ja') {
          document.getElementById('book_language').value = '日本語';
        } else {
          document.getElementById('book_language').value = data.language;
        }
        document.getElementById('book_company').value = data.company;
      }
    })
    .catch(error => console.error('Error:', error));
});
