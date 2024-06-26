<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<%@ include file="/WEB-INF/views/common/mainTab.jsp" %>

	<div class="container">
		<section class="contents main">
			
			<div class="main_tab">
				<h2 class="hidden">웹툰 메인</h2>
				
				<!-- <div class="tab_btns days">
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
				</div> -->
				<input type="hidden" id="tabName" value="<c:out value='${param.tab}'></c:out>">
				
				<div class="tab_contents">
					<div class="recommend_area">
						<!-- <h3>추천 웹툰</h3>
						<ul class="recommend_list">
							<li>
								<a href="#" class="list_item">
									<div class="comics_thumb">
				                  		<img src="" alt="작품 썸네일">
				                  	</div>
				                  	<div class="comics_info">
				                    	<div class="comics_title">
				                      		작품 제목
				                    	</div>
				                    	<div class="comics_creators">
				                      		작가명
				                    	</div>
				                    	<div class="comics_intro">
				                      		소개글 소개글 소개글을 길게 쓸 경우를 대비해서 2줄 제한을 둘거니까 이렇게 써보기 소개글 소개글 소개글을 길게 쓸 경우를 대비해서 2줄 제한을 둘거니까 이렇게 써보기 소개글 소개글 소개글을 길게 쓸 경우를 대비해서 2줄 제한을 둘거니까 이렇게 써보기
				                    	</div>
				                  	</div>
				                </a>
							</li>
							<li>
								<a href="#" class="list_item">
									<div class="comics_thumb">
				                  		<img src="" alt="작품 썸네일">
				                  	</div>
				                  	<div class="comics_info">
				                    	<div class="comics_title">
				                      		작품 제목
				                    	</div>
				                    	<div class="comics_creators">
				                      		작가명
				                    	</div>
				                    	<div class="comics_intro">
				                      		소개글 소개글 소개글을 길게 쓸 경우를 대비해서 2줄 제한을 둘거니까 이렇게 써보기 소개글 소개글 소개글을 길게 쓸 경우를 대비해서 2줄 제한을 둘거니까 이렇게 써보기 소개글 소개글 소개글을 길게 쓸 경우를 대비해서 2줄 제한을 둘거니까 이렇게 써보기
				                    	</div>
				                  	</div>
				                </a>
							</li>
							<li>
								<a href="#" class="list_item">
									<div class="comics_thumb">
				                  		<img src="" alt="작품 썸네일">
				                  	</div>
				                  	<div class="comics_info">
				                    	<div class="comics_title">
				                      		작품 제목
				                    	</div>
				                    	<div class="comics_creators">
				                      		작가명
				                    	</div>
				                    	<div class="comics_intro">
				                      		소개글 소개글 소개글을 길게 쓸 경우를 대비해서 2줄 제한을 둘거니까 이렇게 써보기 소개글 소개글 소개글을 길게 쓸 경우를 대비해서 2줄 제한을 둘거니까 이렇게 써보기 소개글 소개글 소개글을 길게 쓸 경우를 대비해서 2줄 제한을 둘거니까 이렇게 써보기
				                    	</div>
				                  	</div>
				                </a>
							</li>
							<li>
								<a href="#" class="list_item">
									<div class="comics_thumb">
				                  		<img src="" alt="작품 썸네일">
				                  	</div>
				                  	<div class="comics_info">
				                    	<div class="comics_title">
				                      		작품 제목
				                    	</div>
				                    	<div class="comics_creators">
				                      		작가명
				                    	</div>
				                    	<div class="comics_intro">
				                      		소개글 소개글 소개글을 길게 쓸 경우를 대비해서 2줄 제한을 둘거니까 이렇게 써보기 소개글 소개글 소개글을 길게 쓸 경우를 대비해서 2줄 제한을 둘거니까 이렇게 써보기 소개글 소개글 소개글을 길게 쓸 경우를 대비해서 2줄 제한을 둘거니까 이렇게 써보기
				                    	</div>
				                  	</div>
				                </a>
							</li>
						</ul> -->
					</div>
					
					<div class="tab_content">
						<div class="genre_btns">
							<button type="button" class="genre_btn" value="1">#로맨스</button>
							<button type="button" class="genre_btn" value="2">#판타지</button>
							<button type="button" class="genre_btn" value="3">#액션</button>
							<button type="button" class="genre_btn" value="4">#일상</button>
							<button type="button" class="genre_btn" value="5">#스릴러</button>
							<button type="button" class="genre_btn" value="6">#개그</button>
							<button type="button" class="genre_btn" value="7">#무협/사극</button>
							<button type="button" class="genre_btn" value="8">#드라마</button>
							<button type="button" class="genre_btn" value="9">#감성</button>
							<button type="button" class="genre_btn" value="10">#스포츠</button>
			            </div>
					
						<div class="title_area">
							<h3>제목</h3>
				            <div class="sort_btns">
								<button type="button" class="sort_btn" value="popularity">인기순</button>
								<button type="button" class="sort_btn" value="update">업데이트순</button>
								<button type="button" class="sort_btn" value="view">조회순</button>
								<button type="button" class="sort_btn" value="rating">별점순</button>
				            </div>						
						</div>
			            
						<div id="comicsList_area">
						
						</div>
					</div>
				</div>
			</div>
			
		</section>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>

	<script src="/resources/js/main.js"></script>
</html>