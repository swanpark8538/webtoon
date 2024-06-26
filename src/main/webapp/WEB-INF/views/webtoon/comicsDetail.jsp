<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작품 상세</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div class="container">
		<section class="contents main">
			
			<div class="main_tab">
				<div class="tab_btns days">
					<button type="button" class="tab_btn" value="all">요일 전체</button>
					<button type="button" class="tab_btn" value="1">월</button>
					<button type="button" class="tab_btn" value="2">화</button>
					<button type="button" class="tab_btn" value="3">수</button>
					<button type="button" class="tab_btn" value="4">목</button>
					<button type="button" class="tab_btn" value="5">금</button>
					<button type="button" class="tab_btn" value="6">토</button>
					<button type="button" class="tab_btn" value="0">일</button>
					<button type="button" class="tab_btn" value="genre">장르</button>
					<button type="button" class="tab_btn" value="new">신작</button>
					<button type="button" class="tab_btn" value="finish">완결</button>
				</div>
			</div>
		</section>
	</div>
					
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>