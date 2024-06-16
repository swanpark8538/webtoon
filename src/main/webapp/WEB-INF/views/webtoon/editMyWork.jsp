<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 작품 수정</title>
<!-- 구글 아이콘 -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
<!-- css -->
<link rel="stylesheet" href="/resources/css/webtoon.css" />
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="webtoon-content">	
	<h2>작품 수정하기</h2>
		<div class="webtoon_delete_btn_box">
			<button onclick="openDelModal()" class="webtoon_delete_btn">삭제</button>		
		</div>
		<form action="/webtoon/edit" method="post" enctype="multipart/form-data" class="reg-webtoon-form">
			<div class="reg-input-box">
				<div class="webtoon-thumbnail-box">
					<img class="webtoon-thumbnail-img" src="/webtoon/${w.webtoonThumbnail}">
                        <input type="hidden" value="${w.webtoonThumbnail}" name="oldImgFile">     
					<label for="newImgFile">작품 썸네일 선택하기</label>
					<input type="file" id="newImgFile" name="newImgFile" accept=".jpg,.png,.jpeg" onchange="loadImg(this);" style="display: none">
					<div class="rest_end_checkbox">
					    <label for="rest" class="chk_box">
					        <input type="checkbox" id="rest" name="status" value="2" onclick="toggleCheckbox('rest', 'end')">
					        <span class="on"></span>
					        <span class="chk-text">작품 휴재 처리하기</span>
					    </label>
					    <label for="end" class="chk_box">
					        <input type="checkbox" id="end" name="status" value="0" onclick="toggleCheckbox('end', 'rest')">
					        <span class="on"></span>
					        <span class="chk-text">작품 완결 처리하기</span>
					    </label>
					</div>
				</div>
				<div class="webtoon-input-table" id="webtoon-input-table">
					<table>
						<tbody>
							<tr>
								<td><label for="webtoonTitle">작품명</label></td>
								<td colspan="3">
									<input type="hidden" name="webtoonNo" value="${w.webtoonNo }">
									<input type="text" name="webtoonTitle" id="webtoonTitle" placeholder="작품명을 입력해주세요." value="${w.webtoonTitle }">
								</td>					
							</tr>
							<tr>
								<td><label for="writer">글 작가</label>
								<td>
									
									<input type="hidden" name="writer" value="${w.creator1.memberNo }">
									<input type="text"  id="writer" placeholder="글 작가를 입력해주세요." class="id-input">
									<div class="search-wrap writer-wrap"></div>
									<div class="writer-sub-message">* 아이디를 입력하신 후 선택하여 주세요.</div>						
								</td>
								<td><label for="painter">그림 작가</label>
								<td>
									<input type="hidden" name="painter" value="${w.creator2.memberNo }">
									<input type="text"  id="painter" placeholder="그림 작가를 입력해주세요." class="id-input">
									<div class="search-wrap painter-wrap">
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
									  <input type="radio" id="1" name="webtoonRating" value="1"/><label for="1">전체이용가</label>
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
									<div class="tag-list">
										<c:forEach var="tag" items="${w.hashtag }">
											<div class="add-tag-box">
												<span class="add-tag old-tag">${tag }</span>
												<span class="material-icons tag-close" onclick="delTag(this, '${tag }');">close</span>
											</div>
										</c:forEach>
									</div>
									<input type="text" id="tagIn" placeholder="내 작품을 가장 잘 표현해주는 태그를 입력해 주세요.">
									<div class="search-wrap tag-select-wrap"></div>
									<div class="tag-sub-message-box">
										<div>* 중복은 적용되지 않습니다.</div>
										<div>* 원하는 단어를 입력한 뒤에 엔터키를 입력하시면 태그가 등록됩니다.</div>							
									</div>
								</td>
							</tr>
							<tr>
								<td><label for="webtoonIntro">작품 소개</label></td>
								<td colspan="3"><textarea rows="" cols="" id="webtoonIntro" name="webtoonIntro" placeholder="작품의 줄거리를 작성해주세요.">${w.webtoonIntro }</textarea>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="reg-btn-wrap">
				<button>작품 수정하기</button>
				<div class="back">취소</div>
			</div>
		</form>
    <div class="modal" id="modal">
      <div class="modal_wrap">
        <div class="modal_title"></div>
        <div class="btn_area center">
          <button onclick="closeModal(this)" class="sr-btn">확인</button>
        </div>
      </div>
    </div>
    <div class="modal" id="delModal">
      <div class="modal_wrap">
        <div class="modal_title">작품을 삭제하시겠습니까?</div>
        <div class="btn_area center">
          <a href="/webtoon/delete?webtoonNo=${w.webtoonNo }">
          	<button class="sr-btn">삭제</button>
          </a>
          <button onclick="closeModal(this)" class="sr-btn">취소</button>
        </div>
      </div>
    </div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>	
	
	
	
	<script type="text/javascript">
		document.querySelector(".back").addEventListener("click",function(){
			history.back();
		})
		//삭제 모달
		function openDelModal(){
			document.querySelector('#delModal').style.display = 'block';
		}
		
		//썸네일 띄우기
		function loadImg(obj) {
	      //console.log(obj.files);
	      if (obj.files.length != 0 && obj.files[0] != 0) {
	        const reader = new FileReader();
	        reader.readAsDataURL(obj.files[0]);
	        reader.onload = function (e) {
	          $(obj).parent().find(".webtoon-thumbnail-img").attr("src", e.target.result);
	        }
	      } else {
	        $(obj).parent().find(".webtoon-thumbnail-img").attr("src", "/webtoon/${w.webtoonThumbnail}");
	      }
		}
		
		//수정 전 값 세팅
		const radioValue = "${w.webtoonRating}"; // 서버에서 전달된 값
		const radio = document.querySelector('input[name="webtoonRating"][value="' + radioValue + '"]');
		//console.log(radio);
		//console.log(radioValue);
		if(radio){
			radio.checked=true;
		}
		
        const daysToCheck = ${w.day};
        //console.log(daysToCheck);
        const days = document.querySelectorAll("[name=days]");
        //console.log(days)
        days.forEach(function(checkbox){
        	const value = parseInt(checkbox.value);	//정수로 변환
        	if (daysToCheck.includes(value)) { // 요일 배열에 해당 요일이 포함되어 있다면
		        checkbox.checked = true;
		    }
        })
        
        const genresToCheck = ${w.genre};
        const genres = document.querySelectorAll("[name=genres]");
        genres.forEach(function(checkbox){
        	const value = parseInt(checkbox.value);
        	if(genresToCheck.includes(value)){
        		checkbox.checked = true;
        	}
        })
        
        //완결,휴재 체크박스
        function toggleCheckbox(clickedId, otherId) {
            const clickedCheckbox = document.getElementById(clickedId);
            const otherCheckbox = document.getElementById(otherId);

            if (clickedCheckbox.checked) {
                otherCheckbox.checked = false;
            }
        }
        const restCheckBox = document.querySelector("#rest");
        const endCheckBox = document.querySelector("#end");
        const webtoonIsinseries = ${w.webtoonIsinseries};
        if(webtoonIsinseries=="0"){
        	endCheckBox.checked=true;
        }else if(webtoonIsinseries=="2"){
        	restCheckBox.checked=true;
        }
        
		//해시태그
		const tagInput = document.getElementById('tagIn');
		// 등록된 태그 리스트
		const tagList = document.querySelector('.tag-list');
		// 중복 없는 해시태그를 저장하기 위한 Set
		const tagSet = new Set();
		// 등록된 태그들 set에 등록
		const oldTags = document.querySelectorAll('.old-tag');
		oldTags.forEach(function(oldTag) {
		    tagSet.add(oldTag.textContent);
		});
		//기존태그 삭제 목록
		const delTag = (obj, tag) =>{
			const delTagInput = document.createElement("input");
			delTagInput.setAttribute("type","hidden");
			delTagInput.setAttribute("name","delTags");
			delTagInput.value = tag;
			tagList.appendChild(delTagInput);
			obj.parentElement.remove();
		}
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
	          tagList.removeChild(input);	          
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
		//검색 결과 초기화 함수
	    function removeTagList(){
	      const searchTagList = document.querySelector('.search-tag-list');
	      if(searchTagList !=null){
		      searchTagList.remove();	  
	      }
	    }
		//enter 눌렀을 시
		tagInput.addEventListener('keydown', function(event) {
	      if (event.key === 'Enter') {
	        event.preventDefault();
	        const tagValue = this.value.trim();
	        addTag(tagValue);
	        removeTagList();
	        tagInput.value = '';
	      }
		});
	    // 태그 작성 시
	    tagInput.addEventListener('input', function() {
		    clearTimeout(this.timer); // 이전에 예약된 타이머 제거
		    this.timer = setTimeout(() => {
		    	removeTagList();
		    	if (this.value !== "") {
		            $.ajax({
		              url: "/webtoon/tagSearch",
		              type: "get",
		              data: { hashtag: this.value },
		              dataType: "JSON",
		              success: function(data) {
		                if (data.length > 0) {
		                  const list=document.createElement('div');
		                  list.className="search-list search-tag-list";
		                  for (let i = 0; i < data.length; i++) {
		                    const div = document.createElement('div');
		                    div.className = "search-item";
		                    div.textContent = data[i];
		                    //태그 리스트 선택 시 
		                    div.addEventListener('click', function() {
		                    	addTag(data[i]);
		              	        removeTagList();
		              	        tagInput.value = '';	          
		          	        });	
		                    list.appendChild(div);
		                  }
		                  const wrap = document.querySelector(".tag-select-wrap")
		                  wrap.appendChild(list);
		                }
		              },
		              error: function() {
		                console.log("에러");
		              }
		            });
		          }
		    }, 200);
	    });
		//태그 blur
	    tagInput.addEventListener('blur', function(event) {
	    	clearTimeout(this.timer);
	    	this.timer = setTimeout(() => {
	    		event.target.value="";
	    		removeTagList();
	    	},250);
	    });
		
		/*필요없음
		// list 외부 클릭 시
		document.addEventListener('click', function(event) {
			const target = event.target;
			const searchLists = document.querySelectorAll('.search-list');
			searchLists.forEach(function(searchList) {
				const input = searchList.parentElement.previousElementSibling;
	            if (!target.contains(searchList)&&!target.contains(input)) {
	            	//console.log(input);
	                input.value="";
	                searchList.remove();
	            }
	        });
		});
		*/
		
		//작가
		const writer = document.querySelector('[name="writer"]');
		const painter = document.querySelector('[name="painter"]');
		const writerInput = document.getElementById('writer');
		writerInput.value = "${w.creator1.memberNickname}(${w.creator1.memberId})";
		const painterInput = document.getElementById('painter');
		painterInput.value = "${w.creator2.memberNickname}(${w.creator2.memberId})";
		const writerWrap = document.querySelector('.writer-wrap');
		const painterWrap = document.querySelector('.painter-wrap');
		//input 클릭 시
		writerInput.addEventListener('click',function(event){
			event.target.value="";
			const searchList = document.querySelector('.writer-list');
			if(searchList!=null){
				searchList.remove();				
			}
	        writer.value = "";
		})
		
		painterInput.addEventListener('click',function(event){
			event.target.value="";
			const searchList = document.querySelector('.painter-list');
			if(searchList!=null){
				searchList.remove();				
			}
			painter.value = "";
		})
		//작가관련 blur
	    const idInput = document.querySelectorAll('.id-input');
	    idInput.forEach(input => {
	    	input.addEventListener('blur', function(event) {
	    		clearTimeout(this.timer);
	    		this.timer = setTimeout(() => {
		    		if(event.target.previousElementSibling.value == ""){
		   	    		event.target.value="";
		    		}
		    		const searchList = input.nextElementSibling.querySelector('.search-list');
		    		if(searchList!=null){
		    			searchList.remove();				
		    		}	        	
	    		},250);
	    	});
	    });
		//작가 input 시
		writerInput.addEventListener('input', function() {
			clearTimeout(this.timer);
			this.timer = setTimeout(() => {
		    const writerList = document.querySelector('.writer-list');
		    if(writerList != null){
		    	writerList.remove();
		    }
		    if (this.value.trim() !== "") {
		        $.ajax({
		            url: "/webtoon/searchWriter",
		            type: "get",
		            data: { memberId: this.value },
		            dataType: "JSON", 
		            success: function(data) { 
		                const list = document.createElement('div');
		                list.className="search-list writer-list";
		                if (data.length > 0) {
		                    for (let i = 0; i < data.length; i++) {
					            const div = document.createElement('div');
			                    div.className = "search-item";       
		                        var member = data[i];
		                        div.addEventListener('click', function() {
		                        	writerInput.value=  data[i].memberNickName +"("+ data[i].memberId+")";
		                        	writerInput.previousElementSibling.value=data[i].memberNo;
		                        	list.remove();
			          	        });	
		                        div.textContent = data[i].memberNickName +"("+ data[i].memberId+")";
		                        list.appendChild(div);
		                    }
		                }else{
		                	const div = document.createElement('div');
		                    div.className = "search-none-item";
	                        div.textContent = "해당하는 회원이 없습니다.";
	                        list.appendChild(div);
		                }
		                writerWrap.appendChild(list);
		            },
		            error: function() {
		                console.log("에러");
		            }
		        });
		    }
			},200);
		});
		painterInput.addEventListener('input', function() {
		    const painterList = document.querySelector('.painter-list');
		    if(painterList != null){
		    	painterList.remove();
		    }
		    if (this.value.trim() !== "") {
		        $.ajax({
		            url: "/webtoon/searchWriter",
		            type: "get",
		            data: { memberId: this.value },
		            dataType: "JSON",
		            success: function(data) {  
		                const list = document.createElement('div');
		                list.className="search-list painter-list";
		                if (data.length > 0) {
		                    for (let i = 0; i < data.length; i++) {
		                    	const div = document.createElement('div');
			                    div.className = "search-item";                 
			                    div.addEventListener('click', function() {
			                    	painterInput.value= data[i].memberNickName +"("+ data[i].memberId+")";
			                    	painterInput.previousElementSibling.value=data[i].memberNo;
		                        	list.remove();
			          	        });	
		                        div.textContent = data[i].memberNickName +"("+ data[i].memberId+")";
		                        list.appendChild(div);
		                    }
		                }else{
		                	const div = document.createElement('div');
		                    div.className = "search-none-item";
	                        div.textContent = "해당하는 회원이 없습니다.";
	                        list.appendChild(div);
		                }
		                painterWrap.appendChild(list);
		            },
		            error: function() {
		                console.log("에러");
		            }
		        });
		    }
		});

		
		//제출 관련 함수들
		//모달 열기
		function openModal() {
	        document.getElementById('modal').style.display = 'block';
	    }
		//모달 닫기
	    function closeModal(obj) {
	        obj.parentElement.parentElement.parentElement.style.display = 'none';
	    }
        //모달 외부 클릭시 모달 닫기
        const modals = document.querySelectorAll(".modal");
        modals.forEach(function(modal){
        	modal.addEventListener('click', function(event) {
                if (event.target === modal) {
                    modal.style.display = 'none';
                }
            });
        })
        //input 미입력시 동작 함수
        function noneInputFunc(event,data) {
			const modalTitle = document.querySelector(".modal_title");      	
        	modalTitle.innerText = data
	        openModal();
        	event.preventDefault(); // 폼 제출 막기
		}
		//폼제출 조건
		document.querySelector('.reg-webtoon-form').addEventListener('submit', function(event) {
			//event.preventDefault();	//마지막에 지우기, 확인용으로 제출 막아놈
			const webtoonTitle = document.querySelector("#webtoonTitle");
	        const checkDays = document.querySelectorAll('input[name="days"]:checked');
	        const checkGenres = document.querySelectorAll('input[name="genres"]:checked');

			if(webtoonTitle.value.trim() === ""){
	        	noneInputFunc(event,"작품명을 입력해주세요.");
			}else if(writer.value ===""){
				noneInputFunc(event,"글 작가를 입력해주세요");
			}else if(painter.value ===""){
				noneInputFunc(event,"그림 작가를 입력해주세요");
			}else if (checkDays.length === 0) {
				noneInputFunc(event,"하나 이상의 요일을 선택해주세요.");
	        }else if(checkGenres.length === 0){
				noneInputFunc(event,"하나 이상의 장르를 선택해주세요.");
	        }
		});
	</script>
</body>
</html>