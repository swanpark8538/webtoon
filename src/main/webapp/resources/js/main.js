$(function(){
    $(".main_tab .tab_btns > .tab_btn").eq(0).click();
})
//메인 탭 선택 시
$(".main_tab .tab_btns > .tab_btn").on("click", function(){
  $(".main_tab .sort_btns > .sort_btn").removeClass("active");
  $(".main_tab .sort_btns > .sort_btn").eq(0).addClass("active");

  if($(this).val() === "genre"){
    $(".main_tab .genre_btns > .genre_btn").removeClass("active");
    $(".main_tab .genre_btns > .genre_btn").eq(0).addClass("active");
  }

  const index = $(".main_tab .tab_btns > .tab_btn").index(this);
  $(".main_tab .tab_btns > .tab_btn").removeClass("active");
  $(".main_tab .tab_btns > .tab_btn").eq(index).addClass("active");
  $(".main_tab .tab_contents > .tab_content h3").text($(this).text());

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
    success: function(res){
      console.log(res);
    },
    error: function(res){
      console.log(res);
    }
  })
}
