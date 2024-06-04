<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 작품 등록</title>
<!-- 구글 아이콘 -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
<!-- jquery -->
<script src="/resources/js/jquery-3.6.0.js"></script>
<!-- css -->
<link rel="stylesheet" href="/resources/css/webtoon.css" />
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="webtoon-content" id="webtoon-content">	
	<h2>작품 등록하기</h2>
		<form action="/webtoon/register" method="post" enctype="multipart/form-data" class="reg-webtoon-form">
			<div class="reg-input-box">
				<div class="webtoon-thumbnail-box">
					<img class="webtoon-thumbnail-img" src="/resources/img/none.jpg">
					<label for="imgFile">작품 썸네일 선택하기</label>
					<input type="file" id="imgFile" name="imgFile" accept=".jpg,.png,.jpeg" onchange="loadImg(this);" style="display: none">
				</div>
				<div class="webtoon-input-table" id="webtoon-input-table">
					<table>
						<tbody>
							<tr>
								<td><label for="webtoonTitle">작품명</label></td>
								<td colspan="3"><input type="text" name="webtoonTitle" id="webtoonTitle" placeholder="작품명을 입력해주세요."></td>					
							</tr>
							<tr>
								<td><label for="writer">글 작가</label>
								<td>
									
									<input type="hidden" name="writer" >
									<input type="text"  id="writer" placeholder="글 작가를 입력해주세요." class="search-input">
									<div class="search-wrap">
										<div class="search-list writer-list"></div>
									</div>
									<div class="writer-sub-message">* 아이디를 입력하신 후 선택하여 주세요.</div>						
								</td>
								<td><label for="painter">그림 작가</label>
								<td>
									<input type="hidden" name="painter" >
									<input type="text"  id="painter" placeholder="그림 작가를 입력해주세요." class="search-input">
									<div class="search-wrap">
										<div class="search-list painter-list"></div>
									</div>
									<div class="writer-sub-message">* 아이디를 입력하신 후 선택하여 주세요.</div>
								</td>
							</tr>
							<tr>
								<td>연재 요일</td>
								<td colspan="3">
			                        <label for="monday" class="chk_box">
										<input type="checkbox" id="monday" name="days" value="1">
			            				<span class="on"></span>            
			                        	<span class="chk-text">월</span>
			                        </label>
			                        <label for="tuesday" class="chk_box">
										<input type="checkbox" id="tuesday" name="days" value="2">
			            				<span class="on"></span>            
			                        	<span class="chk-text">화</span>
			                        </label>
			                        <label for="wednesday" class="chk_box">
										<input type="checkbox" id="wednesday" name="days" value="3">
			            				<span class="on"></span>            
			                        	<span class="chk-text">수</span>
			                        </label>
			                        <label for="thursday" class="chk_box">
										<input type="checkbox" id="thursday" name="days" value="4">
			            				<span class="on"></span>            
			                        	<span class="chk-text">목</span>
			                        </label>
			                        <label for="friday" class="chk_box">
										<input type="checkbox" id="friday" name="days" value="5">
			            				<span class="on"></span>            
			                        	<span class="chk-text">금</span>
			                        </label>
			                        <label for="saturday" class="chk_box">
										<input type="checkbox" id="saturday" name="days" value="6">
			            				<span class="on"></span>            
			                        	<span class="chk-text">토</span>
			                        </label>
			                        <label for="sunday" class="chk_box">
										<input type="checkbox" id="sunday" name="days" value="0">
			            				<span class="on"></span>            
			                        	<span class="chk-text">일</span>
			                        </label>
								</td>
							</tr>
							<tr>
								<td>이용 연령</td>
								<td colspan="3">
								<div class="radio-box">
									<input type="radio" id="1" name="webtoonRating" value="1" checked="checked"/><label for="1">전체이용가</label>
		  							<input type="radio" id="2" name="webtoonRating" value="2" /><label for="2">12세 이용가</label>
		  							<input type="radio" id="3" name="webtoonRating" value="3" /><label for="3">15세 이용가</label>
		  							<input type="radio" id="4" name="webtoonRating" value="4" /><label for="4">18세 이용가</label>
								</div>
								</td>
							</tr>
							<tr>
								<td>장르</td>
								<td colspan="3">
									<c:forEach var="g" items="${list }">
									<label for="${g.genreName}"  class="chk_box">
										<input type="checkbox" id="${g.genreName }" name="genres" value="${g.genreNo }" >
			            				<span class="on"></span>            
										<span class="chk-text">${g.genreName}</span>
			                        </label>
									</c:forEach>
								</td>
							</tr>
							<tr>
								<td><label for="tagIn">해시태그</label></td>
								<td colspan="3">
									<div class="tag-list"></div>
									<input type="text" id="tagIn" placeholder="내 작품을 가장 잘 표현해주는 태그를 입력해 주세요." class="search-input">
									<div class="search-wrap">
										<div class="search-list search-tag-list"></div>
									</div>
									<div class="tag-sub-message-box">
										<div>* 중복은 적용되지 않습니다.</div>
										<div>* 원하는 단어를 입력한 뒤에 엔터키를 입력하시면 태그가 등록됩니다.</div>							
									</div>
								</td>
							</tr>
							<tr>
								<td><label for="webtoonIntro">작품 소개</label></td>
								<td colspan="3"><textarea rows="" cols="" id="webtoonIntro" name="webtoonIntro" placeholder="작품의 줄거리를 작성해주세요."></textarea>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="reg-btn-wrap">
				<button>작품 저장하기</button>
			</div>
		</form>
    	<div class="modal" id="modal">
        	<div class="modal_wrap">
            	<div class="modal_title"></div>
             	<div class="btn_area center">
                	<button onclick="closeModal()" class="sr-btn">확인</button>
            	</div>
        	</div>
    	</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>	
	
	
	
	<script type="text/javascript">
		//썸네일 띄우기
		function loadImg(obj) {
		    console.log(obj.files);
		    if (obj.files.length != 0 && obj.files[0] != 0) {
		        const reader = new FileReader();
		        reader.readAsDataURL(obj.files[0]);
		        reader.onload = function (e) {
		            $(obj).parent().find(".webtoon-thumbnail-img").attr("src", e.target.result);
		        }
		    } else {
		        $(obj).parent().find(".webtoon-thumbnail-img").attr("src", "/resources/img/none.jpg");
		    }
		}
		
		//해시태그
		// 검색창 input
		const tagInput = document.getElementById('tagIn');
		// 태그 등록 div
		const tagList = document.querySelector('.tag-list');
		// 중복 없는 해시태그를 저장하기 위한 Set
		const tagSet = new Set();
		// 검색용 리스트 div
		const searchTagList = document.querySelector('.search-tag-list');
		
		// 태그 추가 함수
		function addTag(tagValue) {
			//중복 확인
		    if (tagValue && !tagSet.has(tagValue)) {
		        tagSet.add(tagValue);
		
		        const div = document.createElement('div');
		        div.className = 'add-tag-box';
		
		        const span = document.createElement('span');
		        span.className = 'add-tag';
		        span.textContent = tagValue;
		
		        // 태그 삭제
		        const closeBtn = document.createElement('span');
		        closeBtn.className = 'material-icons tag-close';
		        closeBtn.textContent = 'close';
		        closeBtn.addEventListener('click', function() {
		            tagSet.delete(tagValue);
		            tagList.removeChild(div);
		        });
		
		        // 화면용
		        div.appendChild(span);
		        div.appendChild(closeBtn);
		        tagList.appendChild(div);
		
		        // 전송용
		        const input = document.createElement('input');
		        input.type = 'hidden';
		        input.name = 'tags';
		        input.value = tagValue;
		        tagList.appendChild(input);
		    }
		}
		
		// 검색 결과 초기화 함수 => 나중에 적용할 예정
		function clearSearchResults() {
		    searchTagList.innerHTML = "";
		    searchTagList.style.display = 'none';
		}
		
		//enter 눌렀을 시
		tagInput.addEventListener('keydown', function(event) {
		    if (event.key === 'Enter') {
		        event.preventDefault();
		        const tagValue = this.value.trim();
		        addTag(tagValue);
		        searchTagList.innerHTML = "";
			    searchTagList.style.display = 'none';
			    tagInput.value = '';
		    }
		});
	
		/*
		//검색된 리스트 밖 클릭시 사라지도록 함
	    document.addEventListener('click', function(event) {
	        const searchLists = document.querySelectorAll('.search-list');
	        searchLists.forEach(function(searchList) {
	            if (!searchList.contains(event.target)) {
	                searchList.style.display = 'none';
	                searchList.innerHTML = "";
					searchList.parentElement.previousElementSibling.value="";
	            }
	        });
	    });
		*/
	    const searchInput = document.querySelectorAll('.search-input');
	    searchInput.forEach(item => {
	        item.addEventListener('blur', function(event) {
	        	console.log("블러 작동");
	        	event.target.value="";


	        	const searchList = item.nextElementSibling.querySelector('.search-list');
	        	console.log(searchList);
	        	//searchList.remove();
	            searchList.style.display = 'none';
	            searchList.innerHTML = "";
	        });
	    });
			
		// 태그 작성 시
		tagInput.addEventListener('input', function() {
			clearSearchResults();
		    if (this.value !== "") {
		        //비동기로 저장된 해시태그 가져오기
			    console.log("에이잭스 전 값 : "+ this.value);
		        $.ajax({
		            url: "/webtoon/tagSearch",
		            type: "get",
		            data: { hashtag: this.value },
		            dataType: "JSON", // 문자열을 배열로 받아옴
		            success: function(data) {
		                console.log("에이잭스 작동");  
		                console.log(data);  
		                if (data.length > 0) {
		                    searchTagList.style.display = 'block';
		                    for (let i = 0; i < data.length; i++) {
		                        const div = document.createElement('div');
		                        div.className = "search-item";
		                        div.textContent = data[i];
		                        searchTagList.appendChild(div);
		                    }
		                }
		            },
		            error: function() {
		                console.log("에러");
		                clearSearchResults();
		            }
		        });
		    }else{
		    	clearSearchResults();
		    }
		});
		
		//검색태그에서 선택 시 
		searchTagList.addEventListener('click', function(event) {
		     console.log("선택됨 : "+event.target.innerText);
		    if (event.target && event.target.matches('.search-item')) {
		        var selectTag = event.target.innerText;
		        console.log(selectTag);
		        addTag(selectTag);
		        searchTagList.innerHTML = "";
			    searchTagList.style.display = 'none';
			    tagInput.value = '';
		    }
		});
		//작가
		const writer = document.querySelector('[name="writer"]');
		const painter = document.querySelector('[name="painter"]');
		const writerInput = document.getElementById('writer');
		const painterInput = document.getElementById('painter');
		const writerList = document.querySelector('.writer-list');
		const painterList = document.querySelector('.painter-list');
		
		writerInput.addEventListener('click',function(event){
			event.target.value="";
	        writerList.style.display = 'none';
	        writer.value = "";
		})
		
		painterInput.addEventListener('click',function(event){
			event.target.value="";
			painterList.style.display = 'none';
			painter.value = "";
		})
		
		writerList.addEventListener('click', function(event) {
		    if (event.target && event.target.matches('.search-item')) {
		        writerInput.value = event.target.innerText;
		        writer.value = event.target.dataset.memberNo;
		        writerList.style.display = 'none';
		    }
		});
		
		painterList.addEventListener('click', function(event) {
		    if (event.target && event.target.matches('.search-item')) {
		        painterInput.value = event.target.innerText;
		        painter.value = event.target.dataset.memberNo;
		        painterList.style.display = 'none';
		    }
		});
		
		writerInput.addEventListener('input', function() {
		    console.log(this.value);
		    writerList.innerHTML = "";
		    writerList.style.display = 'none';
		    var value = this.value.trim();
		    if (value !== "") {
		        //비동기로 저장된 회원정보 가져오기
		        $.ajax({
		            url: "/webtoon/searchWriter",
		            type: "get",
		            data: { memberId: this.value },
		            dataType: "JSON", // 문자열을 배열로 받아옴
		            success: function(data) {
		                //console.log(data);  
		                writerList.innerHTML = "";
		                writerList.style.display = 'block';
		                if (data.length > 0) {
		                    for (let i = 0; i < data.length; i++) {
			                	const div = document.createElement('div');
			                    div.className = "search-item";                   
		                        div.dataset.memberNo = data[i].memberNo;
		                        var member=data[i].memberNickName +"("+ data[i].memberId+")";
		                        div.textContent = member;
		                        writerList.appendChild(div);
		                    }
		                }else{
		                	const div = document.createElement('div');
		                    div.className = "search-none-item";
	                        div.textContent = "해당하는 회원이 없습니다.";
	                        writerList.appendChild(div);
		                }
		            },
		            error: function() {
		                console.log("에러");
		                writerList.innerHTML = "";
		                writerList.style.display = 'none';
		            }
		        });
		    }else{
		    	writerList.innerHTML = "";
		    	writerList.style.display = 'none';
		    }
		});
	
		painterInput.addEventListener('input', function() {
		    console.log(this.value);
		    painterList.style.display = 'none';
		    painterList.innerHTML = "";
		    var value = this.value.trim();
		    if (value !== "") {
		        //비동기로 저장된 회원정보 가져오기
		        $.ajax({
		            url: "/webtoon/searchWriter",
		            type: "get",
		            data: { memberId: this.value },
		            dataType: "JSON", // 문자열을 배열로 받아옴
		            success: function(data) {
		                //console.log(data);  
		                painterList.innerHTML = "";
		                painterList.style.display = 'block';
		                if (data.length > 0) {
		                    for (let i = 0; i < data.length; i++) {
			                	const div = document.createElement('div');
			                    div.className = "search-item";                   
		                        div.dataset.memberNo = data[i].memberNo;
		                        var member=data[i].memberNickName +"("+ data[i].memberId+")";
		                        div.textContent = member;
		                        painterList.appendChild(div);
		                    }
		                }else{
		                	const div = document.createElement('div');
		                    div.className = "search-none-item";
	                        div.textContent = "해당하는 회원이 없습니다.";
	                        painterList.appendChild(div);
		                }
		            },
		            error: function() {
		                console.log("에러");
		                painterList.style.display = 'none';
		                painterList.innerHTML = "";
		            }
		        });
		    }else{
		    	painterList.style.display = 'none';
		    	painterList.innerHTML = "";
		    }
		});

		//제출 관련 함수들
		//모달 열기
		function openModal() {
	        document.getElementById('modal').style.display = 'block';
	    }
		//모달 닫기
	    function closeModal() {
	        document.getElementById('modal').style.display = 'none';
	    }
        //모달 외부 클릭시 모달 닫기
        document.getElementById('modal').addEventListener('click', function(event) {
            if (event.target === document.getElementById('modal')) {
                closeModal();
            }
        });
        //input 미입력시 동작 함수
        function noneInputFunc(event,data) {
			const modalTitle=document.querySelector(".modal_title");
        	console.log(event);
        	console.log(data);        	
        	modalTitle.innerText = data
	        openModal();
        	event.preventDefault(); // 폼 제출 막기
		}
		//폼제출 조건
		document.querySelector('.reg-webtoon-form').addEventListener('submit', function(event) {
			//event.preventDefault();	//마지막에 지우기, 확인용으로 제출 막아놈
			const webtoonTitle = document.querySelector("#webtoonTitle");
			const imgFile = document.querySelector("#imgFile");
	        const checkDays = document.querySelectorAll('input[name="days"]:checked');
	        const checkGenres = document.querySelectorAll('input[name="genres"]:checked');

			if(webtoonTitle.value === ""){
	        	noneInputFunc(event,"작품명을 입력해주세요.");
			}else if(imgFile.files.length == 0){
				noneInputFunc(event,"썸네일을 등록해주세요.");
			}else if(writer.value ===""){
				noneInputFunc(event,"작가 아이디를 입력하여 선택해주세요.");
			}else if(painter.value ===""){
				noneInputFunc(event,"그림 작가 아이디를 입력하여 선택해주세요.");
			}else if (checkDays.length === 0) {
				noneInputFunc(event,"하나 이상의 요일을 선택해주세요.");
	        }else if(checkGenres.length === 0){
				noneInputFunc(event,"하나 이상의 장르를 선택해주세요.");
	        }
			
	        /*
	        console.log(webtoonTitle.value);
	        console.log(imgFile.files);
	        console.log(writer.value);
	        console.log(painter.value);
	        console.log(checkDays);
	        console.log(checkGenres);
	        */
		});
	</script>
</body>
</html>