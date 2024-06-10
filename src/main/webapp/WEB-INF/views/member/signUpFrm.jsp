<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

  <!-- 헤더 -->
  <%@ include file="../common/header.jsp" %>
  <!-- /헤더 -->
  
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <!-- 구글 아이콘 -->
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/icon?family=Material+Icons"
    />
    <!-- jquery -->
    <script src="/resources/js/jquery-3.6.0.js"></script>
    <!-- 기본 CSS -->
    <link href="/resources/css/default-psw.css" rel="stylesheet">
    <!-- 페이지 CSS -->
    <link href="/resources/css/member/signUpFrm.css" rel="stylesheet">
  </head>
  <body>
  
    <!-- main -->
    <main class="main">
      <!-- join-main -->
      <main class="main-join">
        <h2 class="page-title">회원가입</h2>

        <div class="seperate seperate-right seperate-this">
          <span class="text-color-red">*</span>
          <span>필수입력사항</span>
        </div>

        <form
          action="/member/signUp"
          method="post"
          class="join-form"
          id="join-form"
        >
          <!-- id -->
          <div class="inputWrap-default">
            <label for="memberId">
              <div class="inputTitleDiv">
                <span>아이디</span>
                <span>*</span>
              </div>
            </label>
            <label for="memberId">
              <div class="inputDiv">
                <input type="text" name="memberId" id="memberId" required autofocus />
              </div>
              <div id="memberIdMsg"></div>
            </label>
            <button
              type="button"
              class="btn-default btn-bg-blue_light"
              id="checkId"
            >
              중복 확인
            </button>
          </div>
          <!-- //id -->

          <!-- password -->
          <div class="inputWrap-default">
            <label for="memberPw">
              <div class="inputTitleDiv">
                <span>비밀번호</span>
                <span>*</span>
              </div>
            </label>
            <label for="memberPw">
              <div class="inputDiv">
                <input type="password" name="memberPw" id="memberPw" required
                  placeholder="영어와 숫자를 포함하여 6에서 15글자 사이"/>
              </div>
              <div id="memberPwMsg"></div>
            </label>
          </div>
          <!-- //password -->

          <!-- passwordRe -->
          <div class="inputWrap-default">
            <label for="memberPwRe">
              <div class="inputTitleDiv">
                <span>비밀번호 확인</span>
                <span>*</span>
              </div>
            </label>
            <label for="memberPwRe">
              <div class="inputDiv">
                <input type="password" id="memberPwRe" required />
              </div>
              <div id="memberPwReMsg"></div>
            </label>
          </div>
          <!-- //passwordRe -->

          <!-- nickName -->
          <div class="inputWrap-default">
            <label for="memberNickName">
              <div class="inputTitleDiv">
                <span>닉네임</span>
                <span>*</span>
              </div>
            </label>
            <label for="memberNickName">
              <div class="inputDiv">
                <input
                  type="text"
                  name="memberNickName"
                  id="memberNickName"
                  required
                />
              </div>
              <div id="memberNickNameMsg"></div>
            </label>
            <button
              type="button"
              class="btn-default btn-bg-blue_light"
              id="checkNickName"
            >
              중복 확인
            </button>
          </div>
          <!-- //nickName -->

          <!-- name -->
          <div class="inputWrap-default">
            <label for="memberName">
              <div class="inputTitleDiv">
                <span>이름</span>
                <span>*</span>
              </div>
            </label>
            <label for="memberName">
              <div class="inputDiv">
                <input type="text" name="memberName" id="memberName" required />
              </div>
            </label>
          </div>
          <!-- //name -->

          <!-- email -->
          <div class="inputWrap-default">
            <label for="memberEmail">
              <div class="inputTitleDiv">
                <span>이메일</span>
                <span>*</span>
              </div>
            </label>
            <label for="memberEmail">
              <div class="inputDiv">
                <input
                  type="email"
                  name="memberEmail"
                  id="memberEmail"
                  placeholder="예 : example@gmail.com"
                  required
                />
                <span>03:00</span>
              </div>
              <div id="memberEmailMsg"></div>
            </label>
            <button
              type="button"
              class="btn-default btn-bg-blue_light"
              id="authEmail"
            >
              인증번호 발송
            </button>
          </div>
          <!-- //email -->

          <!-- phone -->
          <div class="inputWrap-default">
            <label for="memberPhone">
              <div class="inputTitleDiv">
                <span>휴대폰</span>
                <span>*</span>
              </div>
            </label>
            <label for="memberPhone">
              <div class="inputDiv">
                <input
                  type="text"
                  name="memberPhone"
                  id="memberPhone"
                  placeholder="숫자만 입력해주세요(예 : 01012345678)"
                  required
                />
              </div>
              <div id="memberPhoneMsg"></div>
            </label>
            <button
              type="button"
              class="btn-default btn-bg-blue_light"
              id="authPhone"
            >
              본인 인증
            </button>
          </div>
          <!-- //phone -->

          <!-- address -->
          <div class="inputWrap-address">
            <div class="inputTitleDiv">
              <span>주소</span>
            </div>
            <div class="inputDivWrap">
              <div class="inputDiv">
                <input
                  type="text"
                  name="memberAddressMain"
                  id="memberAddressMain"
                  placeholder="주소를 검색해주세요."
                  readonly
                />
              </div>
              <div class="inputDiv">
                <input
                  type="text"
                  name="memberAddressDetail"
                  id="memberAddressDetail"
                  placeholder="상세주소를 입력해주세요."
                />
              </div>
            </div>
            <button
              type="button"
              class="btn-default btn-bg-blue_light"
              id="searchAddress"
            >
              주소 검색
            </button>
          </div>
          <!-- //address -->

          <!-- birthdate -->
          <div class="inputWrap-birthdate">
            <label for="memberBirthdate">
              <div class="inputTitleDiv">
                <span>주민등록번호</span>
                <span>*</span>
              </div>
            </label>
            <label for="memberBirthdate">
              <div class="inputDiv-b">
                <input
                  type="text"
                  name="memberBirthdate"
                  id="memberBirthdate"
                  required
                />
              </div>
              <div id="memberBirthdateMsg"></div>
            </label>
            <div class="dashDiv">
              <span>-</span>
            </div>
            <label for="memberGender">
              <div class="inputDiv-g">
                <input
                  type="text"
                  name="memberGender"
                  id="memberGender"
                  required
                />
                <span>******</span>
              </div>
              <div id="memberBirthdateMsg"></div>
            </label>
          </div>
          <!-- //birthdate -->
        </form>

        <div class="seperate seperate-right seperate-this"></div>

        <div>
          이용약관 동의 부분
        </div>

        <div class="seperate seperate-right seperate-this"></div>

        <div class="btnArea">
          <button
            type="submit"
            form="join-form"
            class="btn-big btn-bg-blue_bold"
            id="signUpBtn"
          >
            가입하기
          </button>
        </div>
        
      </main>
      <!-- //join-main -->
    </main>
    <!-- //main -->

    <!-- 푸터 -->
    <jsp:include page="../common/footer.jsp"></jsp:include>

    <!-- 페이지 js -->
    <script src="/resources/js/member/signUpFrm.js"></script>
    
  </body>
</html>
