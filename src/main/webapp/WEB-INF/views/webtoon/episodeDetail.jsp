<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div class="container">
		<section class="contents episodeDetail">
            <section class="detail_section">
                <div class="view_area">
                    <div class="view_toolbar_top">
                        <div class="detail_inner">
                            <h2>${episode.epiTitle}</h2>
                            <a href="#" class="btn_back"><span class="hidden">이전</span></a>
                        </div>
                    </div>
    
                    <div class="view_contents">
                        <div class="detail_inner">
                            <c:forEach items="${episode.episodeFile}" var="img">
                                <img src="/webtoon/episode/${img.fileName}" alt="comic content">
                            </c:forEach>
                        </div>
                    </div>
    
                    <div class="view_toolbar_bottom">
                    <c:choose>
                    	<c:when test="${episode.epiNo == episode.firstEpiNo}">
                        	<a href="javascript:void(0);" class="link_preview disabled">이전화</a>
                    	</c:when>
                    	<c:when test="${episode.epiNo > episode.firstEpiNo}">
                        	<a href="/webtoon/episode?webtoonNo=${episode.webtoonNo}&reqNo=${episode.realEpiNo-1}" class="link_preview">이전화</a>
                    	</c:when>
                    </c:choose>
                        <button type="button" class="link_list">목록</button>
					<c:choose>
                    	<c:when test="${episode.epiNo == episode.newestEpiNo}">
                        	<a href="javascript:void(0);" class="link_next disabled">다음화</a>
                    	</c:when>
                    	<c:when test="${episode.epiNo < episode.newestEpiNo}">
                        	<a href="/webtoon/episode?webtoonNo=${episode.webtoonNo}&reqNo=${episode.realEpiNo+1}" class="link_next">다음화</a>
                    	</c:when>
                    </c:choose>
                    </div>
                </div>
    
                <div class="btn_area">
                    <button class="btn_primary btn_add">관심 웹툰 추가</button>
                    <button class="btn_primary outline btn_rating" onclick="openModal(ratingModal)">별점 주기</button>
                </div>
            </section>

            <section class="comments_section">
                <div class="detail_inner">
                    <div class="message_area">
                        <div class="title_wrap">
                            <strong class="title">작가의 말</strong>
                            <span class="creator">누구 글 / 누구 그림</span>
                        </div>
                        <div class="message_wrap">
                            작가의 말 내용
                        </div>
                    </div>

                    <div class="comments_area">
                        <div class="comment_reg_wrap">
                            <div class="comment_writer">작성자 아이디</div>
                            <div class="input_wrap comment">
                                <div class="textarea">
                                    <textarea placeholder="댓글을 입력하세요"></textarea>
                                </div>
                                <button type="button" class="btn_reg_comment">등록</button>
                            </div>
                        </div>

                        <div class="comments_wrap">
                            <div class="sort_btns">
                                <button type="button" class="sort_btn" value="popularity">BEST 댓글</button>
                                <button type="button" class="sort_btn" value="update">전체 댓글</button>
                            </div>

                            <div class="comments">
                                <!-- <div class="comment_wrap">
                                    <div class="comment">
                                        <div class="comment_info">
                                            <strong class="comment_writer">작성자닉네임(아이디****)</strong>
                                            <span class="comment_date">2024.06.19</span>
                                        </div>
                                        <div class="comment_content">
                                            댓글 내용 댓글 내용<br>
                                            어쩌구 저쩌구
                                        </div>
                                        <button type="button" class="btn_recomment">답글</button>
                                        <button type="button" class="btn_like">좋아요<span>26444</span></button>
                                    </div>
                                    <div class="recomment_wrap">
                                        <div class="comment recomment">
                                            <div class="comment_info">
                                                <strong class="comment_writer">작성자닉네임(아이디****)</strong>
                                                <span class="comment_date">2024.06.19</span>
                                            </div>
                                            <div class="comment_content">
                                                댓글 내용 댓글 내용<br>
                                                어쩌구 저쩌구
                                            </div>
                                            <button type="button" class="btn_like">좋아요<span>26444</span></button>
                                        </div>
                                        <div class="comment_reg_wrap">
                                            <div class="comment_writer">작성자 아이디</div>
                                            <div class="input_wrap comment">
                                                <div class="textarea">
                                                    <textarea placeholder="댓글을 입력하세요"></textarea>
                                                </div>
                                                <button type="button" class="btn_reg_comment">등록</button>
                                            </div>
                                        </div>
                                        <button type="button" class="btn_recomment_open">답글 접기</button>
                                    </div>
                                </div> -->
                            </div>
                        </div>
                    </div>

                    <div class="btn_area">
                        <button id="commentMore" class="btn_view_more" onclick="getEpiCommentList(${episode.epiNo}, ${commentCount});">더보기</button>
                    </div>
                </div>
            </section>
            <button id="test">테스트!!!!!!!!!!!!!!</button>
		</section>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <div id="ratingModal" class="modal" style="display:none;">
        <div class="modal_wrap">
            
            <div class="modal_header">
                <div class="modal_title">모달 타이틀</div>
            </div>
    
            <div class="modal_container">
                <div class="modal_content">
					
                </div>
            </div>
            
            <div class="modal_footer">
                <div class="btn_area">
                    <button type="button" onclick="closeModal(this);" class="btn_primary outline">취소</button>
                    <button type="button" onclick="closeModal(this);" class="btn_primary">확인</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 댓글 출력
        let start = 1;
        let amount = 10;
        let currentCount = 0;
        const getEpiCommentList = (epiNo, totalCount)=>{
            // console.log(totalCount);

            $.ajax({
                url: "/webtoon/episodeComment",
                type: "GET",
                data: {epiNo, start, amount},
                success: function(data){
                    // console.log(data);
                    start = start + amount;
                    currentCount = currentCount + data.length;

                    $(data).each(function(index, comment){
                        const commentWrap = $("<div class='comment_wrap'>");
                        const commentDiv = $("<div class='comment'>");
                        const commentInfo = $("<div class='comment_info'>");
                        const commentWriter = $("<strong class='comment_writer'>"+comment.commentWriter+"</strong>");
                        const commentDate = $("<span class='comment_date'>"+comment.commentDate+"</span>");
                        const commentContent = $("<div class='comment_content'>"+comment.commentContent+"</div>");
                        const btnRecomment = $("<button type='button' class='btn_recomment'>답글<span>"+comment.recommentList.length+"</span></button>");
                        const btnLike = $("<button type='button' class='btn_like'>좋아요<span>"+comment.likeCount+"</span></button>");

                        commentInfo.append(commentWriter);
                        commentInfo.append(commentDate);
                        commentDiv.append(commentInfo);
                        commentDiv.append(commentContent);
                        commentDiv.append(btnRecomment);
                        commentDiv.append(btnLike);
                        commentWrap.append(commentDiv);

                        const recommentWrap = $("<div class='recomment_wrap' style='display: none;'>");
                        const commentRegWrap = $("<div class='comment_reg_wrap'>");
                        const regCommentWriter = $("<div class='comment_writer'>");
                        const inputWrap = $("<div class='input_wrap comment'>");
                        const textareaDiv = $("<div class='textarea'>");
                        const textarea = $("<textarea placeholder='댓글을 입력하세요'>");
                        const btnRegComment = $("<button type='button' class='btn_reg_comment'>등록</button>");
                        const btnRecommentOpen = $("<button type='button' class='btn_recomment_open'>답글 접기</button>");

                        $(comment.recommentList).each(function(idx, recomment){
                            const recommentDiv = $("<div class='comment recomment'>");
                            const commentInfo = $("<div class='comment_info'>");
                            const commentWriter = $("<strong class='comment_writer'>"+recomment.commentWriter+"</strong>");
                            const commentDate = $("<span class='comment_date'>"+recomment.commentDate+"</span>");
                            const commentContent = $("<div class='comment_content'>"+recomment.commentContent+"</div>");
                            const btnLike = $("<button type='button' class='btn_like'>좋아요<span>"+recomment.likeCount+"</span></button>");

                            commentInfo.append(commentWriter);
                            commentInfo.append(commentDate);
                            recommentDiv.append(commentInfo);
                            recommentDiv.append(commentContent);
                            recommentDiv.append(btnLike);
                            
                            recommentWrap.append(recommentDiv);
                        });
                        textareaDiv.append(textarea);
                        inputWrap.append(textareaDiv);
                        inputWrap.append(btnRegComment);
                        commentRegWrap.append(regCommentWriter);
                        commentRegWrap.append(inputWrap);
                        recommentWrap.append(commentRegWrap);
                        recommentWrap.append(btnRecommentOpen);

                        commentWrap.append(recommentWrap);
                        $(".comments_wrap>.comments").append(commentWrap);
                    });

                    $(".btn_recomment").on("click", function(e){
                    	e.stopPropagation();
                        // console.log(this);
                        $(this).closest(".comment_wrap").find(".recomment_wrap").toggle();
                    });


                    if(currentCount >= totalCount){
                        $("#commentMore").remove();
                    };
                },
                error: function(data){
                    console.log(data);
                }
            });
        };
        $("#commentMore").click();

        // 스크롤 이벤트
        const webtoonNo = "${episode.webtoonNo}";
        const epiNo = "${episode.epiNo}";
        let viewPercent = 0;
        
        var checkUnload = true;
        $(window).on("beforeunload", function(){
            if(checkUnload){
            	$.ajax({
                    url: "/webtoon/insertViewPercent",
                    type: "GET",
                    data: {webtoonNo, epiNo, viewPercent},
                    success: function(data){

                    },
                    error: function(data){
                        console.log(data);
                    }
                });
            };
        });

        $(window).on("load", function(){
            let beforeScroll = 0;
            let currentScroll = 0;
            
            $(".contents.episodeDetail .view_area .view_toolbar_top, .contents.episodeDetail .view_area .view_toolbar_bottom").addClass("active");
            
	        function getScrollPer(){
		        let vcTop = $(".view_contents").position().top;
		        let vcHeight = $(".view_contents").outerHeight();
		        let windowHeight = $(window).height();
		        // console.log("뷰컨텐츠 top: " + vcTop);
		        // console.log("뷰컨텐츠 height: " + vcHeight);
		        // console.log("화면높이: " + windowHeight);
		        
		        $(window).on("scroll", function(){
		        	currentScroll = $(window).scrollTop();
		        	viewPercent = Math.round((($(window).scrollTop()) / (vcHeight + vcTop - windowHeight)) * 100) < 100 ? Math.round((($(window).scrollTop()) / (vcHeight + vcTop - windowHeight)) * 100) : 100;
		            // console.log(viewPercent);
		            if(currentScroll > beforeScroll){
		            	$("#header").css("top", "-65px");
		            	$(".contents.episodeDetail .view_area .view_toolbar_top, .contents.episodeDetail .view_area .view_toolbar_bottom").removeClass("active");
		            	$(".contents.episodeDetail .view_area .view_toolbar_top").css("top", "0");
		            }else{
		            	$("#header").css("top", "0");
		            	$(".contents.episodeDetail .view_area .view_toolbar_top").css("top", "65px");
		            };
		            beforeScroll = currentScroll;
		        });
	        };
	        getScrollPer();
	        $(window).on("resize", function(){
	        	getScrollPer();
	        });
	        
	        $(document).on("click", function(){
	        	$(".contents.episodeDetail .view_area .view_toolbar_top, .contents.episodeDetail .view_area .view_toolbar_bottom").toggleClass("active");
	        })
        })

        // 모달
        function openModal(popupId){
            $(popupId).show();
            $("html").addClass("scroll_fixed");
        };
        function closeModal(obj){
            $(obj).closest(".modal").hide();
            $("html").removeClass("scroll_fixed");
        };
    </script>
</html>