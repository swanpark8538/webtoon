<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

  <!-- 헤더 -->
  <%@ include file="../common/header.jsp" %>
  <!-- /헤더 -->
  
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <!-- 구글 아이콘 -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <!-- jquery -->
  <script src="/resources/js/jquery-3.6.0.js"></script>
  <!-- 기본 CSS -->
  <link rel="stylesheet" href="/resources/css/default-psw.css" />
  <!-- 페이지 CSS -->
  <link rel="stylesheet" href="/resources/css/member/signInFrm.css" />
</head>
<body>
  <!-- main -->
  <main class="main">

    <!-- main-signIn -->
    <main class="main-signInFrm">

      <h2 class="page-title">로그인</h2>

      <div class="seperate seperate-right seperate-this"></div>

      <form action="/member/signIn" method="post" class="signIn-form" id="signIn-form">

        <!-- id -->
        <div class="inputWrap-default">
          <label for="memberId">
            <div class="inputTitleDiv">
              <span>아이디</span>
            </div>
          </label>
          <label for="memberId">
            <div class="inputDiv">
              <input type="text" name="memberId" id="memberId">
            </div>
          </label>
        </div>
        <!-- //id -->

        <!-- password -->
        <div class="inputWrap-default">
          <label for="memberPw">
            <div class="inputTitleDiv">
              <span>비밀번호</span>
            </div>
          </label>
          <label for="memberPw">
            <div class="inputDiv">
              <input type="password" name="memberPw" id="memberPw">
            </div>
          </label>
        </div>
        <!-- //password -->

        <div class="findMy">
          <a href="#" id="findMyId">아이디 찾기</a>
          <span>ㅣ</span>
          <a href="#" id="findMyPw">비밀번호 찾기</a>
        </div>

      </form>
      <!-- //form -->

      <div class="seperate seperate-right seperate-this">
        <c:if test="${not empty sessionScope.signInFailCount }">
          <span class="text-color-red">
              로그인 [[${sessionScope.signInFailCount}]]회 실패.
              로그인 [[${signInFailCountLimit}]]회 실패시 일정 시간 로그인 제한
          </span>
        </c:if>
      
      </div>

      <div class="btnArea">
        <button type="submit" form="signIn-form" class="btn-big btn-bg-blue_bold" id="signInBtn">로그인</button>
      </div>

    </main>
    <!-- //main-signIn -->

  </main>
  <!-- //main -->

  <!-- 푸터 -->
  <jsp:include page="../common/footer.jsp"></jsp:include>

</body>
</html>