<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회차 등록</title>
<link rel="stylesheet" href="/resources/css/webtoon.css" />
<!-- 
<link rel="stylesheet" href="/resources/js/jquery-ui-1.13.3/jquery-ui.css">
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
 -->
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="webtoon-content">	
		<h2>신규 회차 등록</h2>
		<form action="/webtoon/regEpisode" method="post" enctype="multipart/form-data" class="reg-webtoon-form">
			<div class="reg-input-box">
				<div class="webtoon-thumbnail-box">
					<img class="webtoon-thumbnail-img" src="/resources/img/none.jpg">
					<label for="imgFile">회차 썸네일 선택하기</label>
					<input type="file" id="imgFile" name="imgFile" accept=".jpg,.png,.jpeg" onchange="loadImg(this);" style="display: none">
				</div>
				<div class="webtoon-input-table" id="webtoon-input-table">
					<table>
						<tbody>
							<tr>
								<td>회차명</td>
								<td><input type="text" disabled value="${webtoonTitle }">
								<input type="hidden" value="${webtoonNo }" name="webtoonNo" id="webtoonNo"> </td>
							</tr>
							<tr>
								<td>회차 번호</td>
								<td>
									<input type="text" disabled value="${epiNo }">
									<div class="writer-sub-message">* 회차 번호는 순차적으로 자동 지정되기 때문에 임의로 설정이 불가능합니다.</div>
								</td>
							</tr>
							<tr>
								<td><label for="epiTitle">회차 제목</label>
								<td>
									<input type="text" id="epiTitle" name="epiTitle" placeholder="회차 제목을 입력해주세요.">
								</td>
							</tr>
							<tr>
								<td>원고 등록</td>
								<td>
									<div class="episode_file_box_wrap">
										<div class="episode_file_box">
											<div>파일 목록</div>
											<div class="episode_file_list"></div>	
											<div class="episode_file_btn_box">
												<div id="editButton"><label for="">수정</label></div>
            									<div id="deleteButton">삭제</div>
												<input type="file" id="work" accept=".jpg, .jpeg, .gif, .png" class="blind" multiple onchange="workImg(this);">
												<input type="file" id="editWork" accept=".jpg, .jpeg, .gif, .png" class="blind" onchange="editWorkImg(this);">										
												<div><label for="work">원고 업로드</label></div>
											</div>						
										</div>
										<div class="episode_file_box">
											<div>미리보기</div>
											<div class="episode_file_show"></div>
											<div class="episode_file_btn_box">											
												<div id="previewButton">전체 미리보기</div>
											</div>	
										</div>
									</div>
									<div class="sub-message-box">
										<div class="writer-sub-message">* 가로 사이즈는 690px를 권장합니다.</div>
										<div class="writer-sub-message">* jpg, gif, png 파일만 업로드 가능</div>									
									</div>
								</td>
							</tr>
							<tr>
								<td><label for="epiMessage">작가의 말</label></td>	
								<td><textarea id="epiMessage" name="epiMessage" placeholder="작가의 말을 입력해 주세요."></textarea></td>
							</tr>
							<tr>
								<td>공개 설정</td>
								<td>
									<div class="radio-box">
									  <input type="radio" id="1" name="epiOpen" value="1" checked="checked"/><label for="1">공개</label>
					                  <input type="radio" id="2" name="epiOpen" value="2" /><label for="2">공개 예약</label>
									</div>
									<!-- 
										<div class="epiOpenDate_box">
											<div id="datepicker"></div>
											<input type="text" id="timepicker">
											<div id="timepicker1"></div>
										</div>																		
									 -->
									 <div class="epiOpenDate_box">
										<input type="datetime-local" 
										  id="epiOpenDate" name="epiOpenDate">
										<div class="writer-sub-message">* 지정된 시간에 맞춰 회차가 공개됩니다.</div>
									 </div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="reg-btn-wrap">
				<button>등록하기</button>
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
		<div class="modal" id="previewModal">
			<div class="modal_wrap" id="preview_wrap">
			  <span class="material-icons previewClose">close</span>
			  <div class="preview_header">
			    <div id="episodeTitle"></div>
			  	<div>[작가의 말] <span class="creator_words"></span></div>		
			  </div>
			  <div class="preview_body" id="previewContent"></div>
			</div>
		</div>
	</div>
	<!-- 
	<script src="/resources/js/jquery-ui-1.13.3/jquery-ui.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>	
	 -->
	<script src="/resources/js/sweetalert.min.js"></script>
	<script type="text/javascript">
		//취소버튼
		$('.back').on('click', function() {
	        history.back();
	    });
		
		//원고 등록 관련
		let selectedFiles = []; // 선택된 파일들을 저장할 배열
		// 파일 목록 표시
		function workImg(obj) {
		    const files = obj.files;
		    if (files.length != 0 && files[0] != 0) {
		        for (let i = 0; i < files.length; i++) {
		            let file = files[i];
		            selectedFiles.push(file);	//배열에 파일 추가
		            let name = file.name;
		            let fileDiv = $('<div class="epi_file_name">' + name + '</div>');
		     		//목록 선택 시
		            fileDiv.on('click', function() {
		                if ($(this).hasClass('file_active')) {
		                    $(this).removeClass('file_active');
		                    $('.episode_file_show').empty();
		                } else {
		                    $('.epi_file_name').removeClass('file_active');
		                    $(this).addClass('file_active');
		                    let reader = new FileReader();
		                    reader.onload = function(e) {
		                        $('.episode_file_show').empty().append('<img src="' + e.target.result + '" alt="' + name + '"/>');
		                    };
		                    reader.readAsDataURL(file);
		                }
		            });
		            $(".episode_file_list").append(fileDiv);
		        }
		    }
		}
		
		// 파일 삭제
		$('#deleteButton').on('click', function() {
			const activeFile = $('.epi_file_name.file_active');
			if (activeFile.length > 0) {
				activeFile.each(function() {
			        const index = $(this).index();
			        console.log(index);
			        selectedFiles.splice(index, 1);
			        $(this).remove();
			        $('.episode_file_show').empty();
			    });
            } else {
                alert('삭제할 파일을 선택하세요.');
            }
		});
        
        // 파일 수정
        $('#editButton').on('click', function() {
            const activeFile = $('.epi_file_name.file_active');
            if (activeFile.length > 0) {
                $('#editWork').click();
            } else {
                alert('수정할 파일을 선택하세요.');
            }
        });

        // 수정된 파일 교체
        function editWorkImg(obj) {
        	const files = obj.files;
            if (files.length != 0 && files[0] != 0) {
                const activeFile = $('.epi_file_name.file_active');
                const index = activeFile.index();
                selectedFiles[index] = files[0]; // 해당 인덱스에 파일 교체

                let name = files[0].name;
                activeFile.text(name); // 파일 목록에 이름 업데이트

                let reader = new FileReader();
                reader.onload = function(e) {
                    $('.episode_file_show').empty().append('<img src="' + e.target.result + '" alt="' + name + '"/>');
                };
                reader.readAsDataURL(files[0]);
            }
        }
        
        
		//전체 미리보기   
		$('#previewButton').on('click', function() {
		    console.log(selectedFiles);
		    const previewContent = $('#previewContent');
		    previewContent.empty();  // 초기화

		    if (selectedFiles.length > 0) {
		        // 파일을 순차적으로 읽어서 미리보기에 추가
		        previewFilesSequentially(selectedFiles, previewContent)
		            .then(() => {
		                $("#episodeTitle").text($("#epiTitle").val());
		                $(".creator_words").text($("#epiMessage").val());
		                $('#previewModal').show();
		            })
		            .catch(error => {
		                console.error('미리보기 오류:', error);
		            });
		    } else {
		        alert('파일이 업로드되지 않았습니다.');
		    }
		});
		//파일들을 순차적으로 보여주기 위함
		function previewFilesSequentially(files, container) {
		    return files.reduce((promise, file) => {
		        return promise.then(() => {
		            return new Promise((resolve, reject) => {
		                let reader = new FileReader();
		                reader.onload = function(e) {
		                    let img = $('<img>').attr('src', e.target.result);
		                    container.append(img);
		                    resolve();
		                };
		                reader.onerror = function(e) {
		                    reject(e);
		                };
		                reader.readAsDataURL(file);
		            });
		        });
		    }, Promise.resolve());
		}
		//모달 닫기
	    $(".previewClose").on('click', function() {
	    	$('#previewModal').hide();
	    });
	  	
		//썸네일 띄우기
		function loadImg(obj) {
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
		
		const now = new Date();
	    const offset = now.getTimezoneOffset() * 60000;
	    const localISOTime = new Date(now.getTime() - offset).toISOString().slice(0, 16);
	    document.getElementById('epiOpenDate').value = localISOTime;
	    document.getElementById('epiOpenDate').setAttribute("min", localISOTime);
	    document.querySelectorAll('input[name="epiOpen"]').forEach(function(radio) {
		    radio.addEventListener('change', function() {
		        if (this.value == '2') {
		            document.querySelector('.epiOpenDate_box').style.display = 'block';
		        } else {
		            document.querySelector('.epiOpenDate_box').style.display = 'none';
		        }
		    });
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
        //event.preventDefault(); // 폼 제출 막기, 현재 페이지에선 ajax씀으로 막음
      }
	  //폼제출 조건
		document.querySelector('.reg-webtoon-form').addEventListener('submit', function(event) {
			event.preventDefault();	//마지막에 지우기, 확인용으로 제출 막아놈sss
			//원고 목록 폼에 포함시킴
			const form = this;
            const formData = new FormData(form);           
            for (let i = 0; i < selectedFiles.length; i++) {
                formData.append('epiFiles', selectedFiles[i]);
            }
		      
            const epiOpenDate = new Date($('#epiOpenDate').val());
			if($("#epiTitle").val().trim() === ""){
	        	noneInputFunc(event,"회차명 입력해주세요.");
			}else if($("#imgFile")[0].files.length == 0){
				noneInputFunc(event,"회차 썸네일을 등록해주세요")
			}else if (selectedFiles.length == 0 || selectedFiles[0] == 0){
                noneInputFunc(event, "원고를 등록해주세요.");
			}else if(($('input[name="epiOpen"]:checked').val() === "2") && (epiOpenDate<=now)){
				noneInputFunc(event, "공개예약 시간을 확인해주세요.");
			}else{
				//원고 때문에 비동기 처리해야함
				$.ajax({
					url : "/webtoon/regEpisode",
					type : "post",
					data : formData,
					processData  : false,	//enctype
					contentType : false,
					success : function(data){
						console.log(data);
						if (data==1) {
							swal({
								title : '회차 등록 성공',
								text : '회차가 등록되었습니다.',
								icon : 'success'
							}).then(function(){
								location.href = "/webtoon/manageEpi?webtoonNo=" + $("#webtoonNo").val();
							});
						}else{
							swal({
								title : '회차 등록 실패',
								text : '잠시 후 시도해주세요.',
								icon : 'error'
							}).then(function(){
								location.href = "/webtoon/manageEpi?webtoonNo=" + $("#webtoonNo").val();
							});
						}
					},
					error : function(){
						console.log("에러");					
					}
				});
			}
		});
	    
	    /*
		$( "#datepicker" ).datepicker({
			dateFormat: 'yy-mm-dd',
			//showOn : "button",
			//buttonText:"날짜 선택",
		    prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    dayNames: ['일','월','화','수','목','금','토'],
		    dayNamesShort: ['일','월','화','수','목','금','토'],
		    dayNamesMin: ['일','월','화','수','목','금','토'],
		    yearSuffix: '년',
		    minDate: "0",
	        changeMonth: true,
	        changeYear: true,
	      //onSelect: select
		});
		$('#timepicker').timepicker({
            timeFormat: 'HH:mm',
            interval: 10,
            minTime: '10',
            maxTime: '6:00pm',
            defaultTime: '11',
            startTime: '10:00',
            dynamic: false,
            dropdown: true,
            scrollbar: true
        })*/
	</script>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>	
</body>
</html>