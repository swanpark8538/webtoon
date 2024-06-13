$(function(){
  $(".main_tab .tab_btns > .tab_btn").eq(0).click();
  $(".genre_btns").hide();
})
//메인 탭 선택 시
$(".main_tab .tab_btns > .tab_btn").on("click", function(){
  $(".genre_btns").hide();
  $(".main_tab .sort_btns > .sort_btn").removeClass("active");
  $(".main_tab .sort_btns > .sort_btn").eq(0).addClass("active");

  if($(this).val() === "genre"){
    $(".main_tab .genre_btns > .genre_btn").removeClass("active");
    $(".main_tab .genre_btns > .genre_btn").eq(0).addClass("active");
  }

  const index = $(".main_tab .tab_btns > .tab_btn").index(this);
  $(".main_tab .tab_btns > .tab_btn").removeClass("active");
  $(".main_tab .tab_btns > .tab_btn").eq(index).addClass("active");

	if($(this).text() === "요일 전체"){
		$(".main_tab .tab_contents > .tab_content h3").text("요일별 전체 웹툰");
	} else if($(this).text() === "신작"){
		$(".main_tab .tab_contents > .tab_content h3").text("신작 웹툰");
	} else if($(this).text() === "완결"){
		$(".main_tab .tab_contents > .tab_content h3").text("완결 웹툰");
	} else if($(this).text() === "장르"){
    $(".genre_btns").show();
		$(".main_tab .tab_contents > .tab_content h3").text($(".main_tab .genre_btns > .genre_btn").eq(0).text());
	} else{
		$(".main_tab .tab_contents > .tab_content h3").text("전체 "+$(this).text()+"요 웹툰");
	}

  const tab = $(this).val();
  const sort = $(".main_tab .sort_btns > .sort_btn").eq(0).val();
  const genre = $(this).val() === "genre" ? $(".main_tab .genre_btns > .genre_btn").eq(0).val() : null;

  console.log("탭 선택");
  webtoonListAjax(tab, sort, genre);
})
//솔팅 버튼 선택 시
$(".main_tab .sort_btns > .sort_btn").on("click", function(){
  const index = $(".main_tab .sort_btns > .sort_btn").index(this);
  $(".main_tab .sort_btns > .sort_btn").removeClass("active");
  $(".main_tab .sort_btns > .sort_btn").eq(index).addClass("active");

  const tab = $(this).closest(".main_tab").find(".tab_btn.active").val();
  const sort = $(this).val();
  const genre = $(this).closest(".main_tab").find(".tab_btn.active").val() === "genre" ? $(".main_tab .genre_btns > .genre_btn.active").val() : null; 

  console.log("솔팅 선택");
  webtoonListAjax(tab, sort, genre);
})
//장르 버튼 선택 시
$(".main_tab .genre_btns > .genre_btn").on("click", function(){
  $(".main_tab .sort_btns > .sort_btn").removeClass("active");
  $(".main_tab .sort_btns > .sort_btn").eq(0).addClass("active");

  const index = $(".main_tab .genre_btns > .genre_btn").index(this);
  $(".main_tab .genre_btns > .genre_btn").removeClass("active");
  $(".main_tab .genre_btns > .genre_btn").eq(index).addClass("active");

  $(".main_tab .tab_contents > .tab_content h3").text($(this).eq(0).text());

  const tab = "genre";
  const sort = $(".main_tab .sort_btns > .sort_btn").eq(0).val();
  const genre = $(this).val();

  console.log("장르 선택");
  webtoonListAjax(tab, sort, genre);
})
//조회 Ajax
function webtoonListAjax(tab, sort, genre){
  console.clear();
  console.log(tab);
  console.log(sort);
  console.log(genre);

  $.ajax({
    url: "/webtoon",
    type: "GET",
    dataType: "JSON",
    data: {tab, sort, genre},
    success: function(data){
      $("#comicsList_area").empty();

      const listArr = new Array();
      const ul = tab === "all" ? $("<ul class='allday_list'>") : $("<ul>");
      for(let i=0; i<data.length; i++){
        if(i === 0){
          const dayArr = new Array();
          dayArr.push(data[i]);
          listArr.push(dayArr);
        }else{
          if(data[i].serialDay === data[i-1].serialDay){
            listArr[listArr.length-1].push(data[i]);
          }else{
            const dayArr = new Array();
            dayArr.push(data[i]);
            listArr.push(dayArr);
          }
        }
      }

      //화면에는 월~일 순으로 출력해야 해서 배열 수정
      const firstItem = listArr.splice(0,1);
      console.log(firstItem);
      console.log(listArr);
      listArr.push(firstItem[0]);

      //리스트 세팅
      $(listArr).each(function(index, item){
        const li = $("<li>");
        const dayTitle = $("<h4 class='day_title'>");
        const innerUl = tab === "all" ? $("<ul class='day_list'>") : $("<ul class='full_list'>");

        $(item).each(function(idx, itm){
          const innerLi = $("<li>");
          const innerA = $("<a href='/webtoon/comicsDetail?webtoonNo="+itm.webtoonNo+"'>");
          const thumbWrap = $("<div class='item_thumb'>");
          const thumb = $("<img src='/webtoon/"+itm.webtoonThumbnail+"' alt='웹툰썸네일'>");
          const webtoonTitle = $("<div class='item_title'>"+itm.webtoonTitle+"</div>");
          const creators = itm.writerStr !== undefined && tab !== "all" ? $("<div class='creators'>"+itm.writerStr+" / "+itm.painterStr+"</div>") : "";
          const avgRating = tab !== "all" ? $("<div class='avgRating'>"+itm.avgRating+"</div>") : "";
          
          thumbWrap.append(thumb);
          innerA.append(thumbWrap).append(webtoonTitle).append(creators).append(avgRating);
          innerLi.append(innerA);
          innerUl.append(innerLi);
        })

        //전체요일
        if(tab === "all"){
          const date = new Date();
          const today = date.getDay();
          if(today !== 0){
            if(today === index+1){
              li.addClass("active");
            }
          }else{
            if(index === 6){
              li.addClass("active");
            }
          }

          if(index === 0){
            dayTitle.text("월요웹툰");
          }else if(index === 1){
            dayTitle.text("화요웹툰");
          }else if(index === 2){
            dayTitle.text("수요웹툰");
          }else if(index === 3){
            dayTitle.text("목요웹툰");
          }else if(index === 4){
            dayTitle.text("금요웹툰");
          }else if(index === 5){
            dayTitle.text("토요웹툰");
          }else if(index === 6){
            dayTitle.text("일요웹툰");
          }

          li.append(dayTitle);
          li.append(innerUl);
          ul.append(li);
          $("#comicsList_area").append(ul);
        }else{
          $("#comicsList_area").append(innerUl);
        }
      })
    },
    error: function(data){
      console.log(data);
    }
  })
}
