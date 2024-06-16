<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회차 등록</title>
<link rel="stylesheet" href="/resources/css/webtoon.css" />
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="webtoon-content">	
		<h2>회차 관리</h2>
		<a href="/webtoon/regEpisode?webtoonNo=${webtoonNo }">신규 회차 등록</a>
		
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>	
</body>
</html>