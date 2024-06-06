//아이디 제약조건 확인
$("#checkId").keyup(function () {
  const memberId = $(this).val();
  const idRegex = /^[a-z0-9],{6,20}&/; //소문자(영어),숫자의 그룹으로 6~20자 사이를 뜻하는 정규표현식
  if (idRegex.test(id)) {
    $.ajax({
      type: "get",
      url: "/member/checkIdIsDuplicated",
      data: { memberId: memberId },
      dataType: json,
      success: function (result) {
        if ((result.data.message = "success")) {
          //태그 생성
          const div = $("<div>");
          div.addClass("");
          div.text("사용 가능한 아이디입니다.");
          //태그 넣기
          $("#memberId").parent().parent().append(div);
        } else {
          //태그 생성
          const div = $("<div>");
          div.addClass("");
          div.text("사용 불가능한 아이디입니다.");
          //태그 넣기
          $("#memberId").parent().parent().append(div);
        }
      },
      error: function (result) {
        console.log(result.data);
      },
    });
  }
});
