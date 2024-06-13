<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/webtoon.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
<title>내 작품 목록</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="webtoon-content">	
		<h2>내 작품 목록</h2>
		<div class="new_webtoon_register">
			<a href="/webtoon/regMyWorks" class="a_tag_btn">새 작품 등록하기</a>	
		</div>
		<div>
			<div class="my_works_first_box">
				<div>총 ${totalCount }개 작품</div>
				<div class="my_works_type_box">
					<c:choose>
					    <c:when test="${type == 1}">
					        <a href="/webtoon/myWorks?reqPage=1&type=1" class="active">최신 등록순</a>
					        <span>∙</span>
					        <a href="/webtoon/myWorks?reqPage=1&type=2">가나다순</a>
					    </c:when>
					    <c:when test="${type == 2}">
					        <a href="/webtoon/myWorks?reqPage=1&type=1">최신 등록순</a>
					        <span>∙</span>
					        <a href="/webtoon/myWorks?reqPage=1&type=2" class="active">가나다순</a>
					    </c:when>
	    			</c:choose>
				</div>
			</div>
			<ul class="my_works_list">
				<c:forEach var="w" items="${list }">
					<li>
						<div>
							<img src = "/webtoon/${w.webtoonThumbnail}">	
						</div>
						<div class="my_work_info">
							<div>
								<span>${w.webtoonTitle }</span>
								<span>(${w.dayDescription})</span>
							</div>
							<div class="webtoon_avg_rating">
							<span>평균 별점 : </span>
							<c:choose>
								<c:when test="${w.avgRating == -1}">
							            없음
							    </c:when>
							    <c:otherwise>
							       <span class="material-icons">star</span>
							       <span>${w.avgRating}</span> 							    					
							    </c:otherwise>
							</c:choose>
							</div>
							<div>
								<span>연령 등급 : </span>
							    <c:choose>
							        <c:when test="${w.webtoonRating == '1'}">전체 이용가</c:when>
							        <c:when test="${w.webtoonRating == '2'}">12세 이용가</c:when>
							        <c:when test="${w.webtoonRating == '3'}">15세 이용가</c:when>
							        <c:when test="${w.webtoonRating == '4'}">18세 이용가</c:when>
							        <c:otherwise>알 수 없음</c:otherwise>
							    </c:choose>
							</div>
							<div>
								<a href="/webtoon/editMyWork?webtoonNo=${w.webtoonNo}">작품 수정</a>
								<a href="/webtoon/manageEpi?webtoonNo=${w.webtoonNo}">회차 관리</a>
							</div>
						</div>
					</li>
				</c:forEach>
			</ul>
			<div class="pageNavi">${pageNavi }</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>