<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>도서 메인</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

  <style>
    .navbar-brand {
      font-weight: bold;
      font-size: 24px;
    }

    .grid-container {
      display: grid;
      grid-template-columns: repeat(8, 1fr);
      grid-template-rows: repeat(3, 1fr);
      gap: 10px;
      max-width: 900px;
      margin: 0 auto;
    }

    .keyword-box {
      aspect-ratio: 1 / 1;
      display: flex;
      align-items: center;
      justify-content: center;
      background-color: #f8f9fa;
      border: 1px solid #ccc;
      text-decoration: none;
      color: black;
      transition: all 0.2s ease;
    }

    .keyword-box:hover {
      background-color: #e0f0ff;
      border-color: #00aaff;
      cursor: pointer;
    }

    .keyword-box:active {
      transform: scale(0.96);
    }

    .book-grid {
      display: none;
      grid-template-columns: repeat(5, 1fr);
      gap: 20px;
      margin-top: 30px;
    }

    .book-grid.active {
      display: grid;
    }

    .book-card {
      text-align: center;
      transition: transform 0.2s;
    }

    .book-card:hover {
      transform: translateY(-5px);
    }

    .book-card img {
      width: 150px;
      height: 200px;
      object-fit: cover;
    }

    .book-title {
      display: block;
      margin-top: 8px;
      font-weight: bold;
      text-decoration: none;
      color: black;
    }

    .book-title:hover {
      text-decoration: underline;
    }

    .book-author {
      font-size: 14px;
      color: #777;
    }

    .book-price {
      font-size: 15px;
      margin-top: 4px;
    }

    .tab-btn, .sub-tab-btn {
      padding: 6px 12px;
      border: none;
      background: #eee;
      font-weight: bold;
      cursor: pointer;
      white-space: nowrap;
    }

    .tab-btn.active, .sub-tab-btn.active {
      background: #000;
      color: #fff;
    }

    .scroll-wrapper {
      position: relative;
      overflow: hidden;
      margin-top: 20px;
    }

    .scroll-container {
      display: flex;
      overflow-x: auto;
      gap: 8px;
      padding: 10px 0;
      scroll-behavior: smooth;
    }

    .scroll-container::-webkit-scrollbar {
      display: none;
    }

    .scroll-arrow {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      background: rgba(0, 0, 0, 0.1);
      border: none;
      font-size: 18px;
      padding: 5px 10px;
      cursor: pointer;
      z-index: 1;
    }

    .scroll-arrow.left {
      left: 0;
    }

    .scroll-arrow.right {
      right: 0;
    }
  </style>
</head>
<body>
  <nav class="navbar navbar-light bg-light px-4">
    <a class="navbar-brand" href="index.jsp">로고</a>
    <ul class="nav mx-auto">
      <li class="nav-item"><a class="nav-link" href="#">메뉴1</a></li>
      <li class="nav-item"><a class="nav-link" href="#">메뉴2</a></li>
      <li class="nav-item"><a class="nav-link" href="#">메뉴3</a></li>
    </ul>
  </nav>

  <main class="container my-5">
    <h2 class="text-center fw-bold">BOOK KEYWORD</h2>
    <p class="text-center text-muted">키워드로 분류된 다양한 도서</p>

    <div class="grid-container mt-4">
      <% for (int i = 1; i <= 24; i++) { %>
        <a href="#" class="keyword-box">키워드 <%=i%></a>
      <% } %>
    </div> 

    <!-- 탭: 새로 나온 책 / 베스트셀러 -->
    <div class="mt-5 d-flex gap-2">
      <button id="btn-new" class="tab-btn active" onclick="showTab('new')">새로 나온 책</button>
      <button id="btn-best" class="tab-btn" onclick="showTab('best')">베스트셀러</button>
    </div>

    <!-- 새로 나온 책 키워드 탭 -->
    <div id="category-tabs" class="scroll-wrapper">
      <button class="scroll-arrow left" onclick="scrollCategory(-1)">&lt;</button>
      <div class="scroll-container">
        <% String[] categories = {"전체", "문학", "경제/경영", "자기계발", "인문학", "종교", "역사", "예술", "사회과학", "자연과학", "기술/공학", "컴퓨터/IT", "유아", "어린이", "청소년", "학습서", "외국어", "여행", "잡지", "만화", "기타"};
           for (int i = 0; i < categories.length; i++) { %>
          <button class="sub-tab-btn <%= (i == 0 ? "active" : "") %>" onclick="showCategory(event, 'cat<%=i%>')"><%= categories[i] %></button>
        <% } %>
      </div>
      <button class="scroll-arrow right" onclick="scrollCategory(1)">&gt;</button>
    </div>

    <!-- 베스트셀러 주간/월간 탭 -->
    <div id="bestseller-tabs" class="sub-tabs" style="display:none; margin-top: 20px;">
      <button class="sub-tab-btn active" onclick="showCategory(event, 'best-week')">주간</button>
      <button class="sub-tab-btn" onclick="showCategory(event, 'best-month')">월간</button>
    </div>

    <!-- 도서 그리드 출력 -->
    <% for (int i = 0; i < 21; i++) { %>
      <div id="cat-cat<%=i%>" class="book-grid <%= (i == 0 ? "active" : "") %>">
        <% for (int j = 1; j <= 10; j++) { %>
          <div class="book-card">
            <a href="#"><img src="img/표지1.jpg" alt="book"></a>
            <a href="#" class="book-title">키워드 <%= categories[i] %> 도서 <%=j%></a>
            <div class="book-author">작가 이름</div>
            <div class="book-price">₩<%= 10000 + j * 1000 %></div>
          </div>
        <% } %>
      </div>
    <% } %>

    <!-- 베스트셀러 주간 -->
    <div id="cat-best-week" class="book-grid">
      <% for (int i = 1; i <= 10; i++) { %>
        <div class="book-card">
          <a href="#"><img src="img/표지1.jpg" alt="book"></a>
          <a href="#" class="book-title">[주간] 도서 <%=i%></a>
          <div class="book-author">작가 이름</div>
          <div class="book-price">₩<%= 10000 + i * 1000 %></div>
        </div>
      <% } %>
    </div>

    <!-- 베스트셀러 월간 -->
    <div id="cat-best-month" class="book-grid">
      <% for (int i = 11; i <= 20; i++) { %>
        <div class="book-card">
          <a href="#"><img src="img/표지1.jpg" alt="book"></a>
          <a href="#" class="book-title">[월간] 도서 <%=i%></a>
          <div class="book-author">작가 이름</div>
          <div class="book-price">₩<%= 10000 + i * 1000 %></div>
        </div>
      <% } %>
    </div>
  </main>

  <footer class="text-center text-muted py-4">
    &copy; 2025 Your Bookstore
  </footer>

  <script>
    function showTab(tab) {
      document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
      document.getElementById('btn-' + tab).classList.add('active');
      document.getElementById('bestseller-tabs').style.display = (tab === 'best') ? 'flex' : 'none';
      document.getElementById('category-tabs').style.display = (tab === 'new') ? 'block' : 'none';
      document.querySelectorAll('.book-grid').forEach(grid => grid.classList.remove('active'));

      if (tab === 'new') {
        document.querySelectorAll('#category-tabs .sub-tab-btn').forEach(btn => btn.classList.remove('active'));
        document.querySelector('#category-tabs .sub-tab-btn:nth-child(1)').classList.add('active');
        document.getElementById('cat-cat0').classList.add('active');
      } else {
        document.querySelectorAll('#bestseller-tabs .sub-tab-btn').forEach(btn => btn.classList.remove('active'));
        document.querySelector('#bestseller-tabs .sub-tab-btn:nth-child(1)').classList.add('active');
        document.getElementById('cat-best-week').classList.add('active');
      }
    }

    function showCategory(event, categoryId) {
      document.querySelectorAll('.sub-tab-btn').forEach(btn => btn.classList.remove('active'));
      event.target.classList.add('active');
      document.querySelectorAll('.book-grid').forEach(grid => grid.classList.remove('active'));
      document.getElementById('cat-' + categoryId).classList.add('active');
    }

    function scrollCategory(direction) {
      const container = document.querySelector('.scroll-container');
      container.scrollLeft += direction * 200;
    }

    window.onload = function () {
      showTab('new');
    }
  </script>
</body>
</html>
