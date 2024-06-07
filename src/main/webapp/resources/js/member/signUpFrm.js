//아이디 제약조건 확인
const checkId = document.getElementById("checkId");
checkId.addEventListener("click", function () {
  const memberId = getElementById("memberId").value;
  const idRegex = /^[a-z0-9]{6,20}$/; //소문자(영어) 또는 숫자의 그룹으로 6~20자 사이를 뜻하는 정규표현식
  if (idRegex.test(memberId)) {
    $.ajax({
      type: "get",
      url: "/member/checkIdIsDuplicated",
      data: { memberId: memberId },
      dataType: json,
      success: function (result) {
        //태그 생성
        const parentParent = document.getElementById("memberId").parentElement.parentElement;
        const div = document.createElement("div");
        if ((result = "success")) {
          div.classList.add("inputMsg-success");
          div.textContent = "사용 가능한 아이디입니다.";
        } else {
          div.classList.add("inputMsg-error");
          div.textContent = "사용 불가능한 아이디입니다.";
        }
        parentParent.appendChild(div);
      },
      error: function (result) {
        console.log(result.data);
      },
    });
  }
});
