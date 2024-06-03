$(function(){
    $(".tab_btns > .tab_btn").eq(0).click();
})
// 메인 탭
$(".tab_btns > .tab_btn").on("click", function(){
    const index = $(".tab_btns > .tab_btn").index(this);
    $(".tab_btns > .tab_btn").removeClass("active");
    $(".tab_btns > .tab_btn").eq(index).addClass("active");
    $(".tab_contents > .tab_content").removeClass("active");
    $(".tab_contents > .tab_content").eq(index).addClass("active");
})

