//아이디 제약조건&중복 확인
document.getElementById("checkId").addEventListener("click", function(){
  const memberIdMsg = document.getElementById("memberIdMsg");
  memberIdMsg.classList.remove(memberIdMsg.classList.item(0));
  memberIdMsg.textContent = "";
  const memberId = document.getElementById("memberId").value;
  const idRegex = /^[a-z0-9]{6,20}$/; //소문자(영어) 또는 숫자의 그룹으로 6~20자 사이
  if (idRegex.test(memberId)) {
    $.ajax({
      type: "get",
      url: "/member/checkIdIsDuplicated",
      data: { memberId: memberId },
      dataType: "json",
      success: function (data) {
        if (data.response = "success") {
        memberIdMsg.classList.add("inputMsg-success");
        memberIdMsg.textContent = "사용 가능한 아이디입니다.";
        } else {
        memberIdMsg.classList.add("inputMsg-error");
        memberIdMsg.textContent = "이미 사용중인 아이디입니다.";
        }
      },
      error: function (data) {
        console.log(data);
      },
    });
  }else {
    memberIdMsg.classList.add("inputMsg-error");
    memberIdMsg.textContent = "소문자(영어) 또는 숫자를 포함하여 6~20글자 사이";
  }
});

//비밀번호 제약조건 확인
document.getElementById("memberPw").addEventListener("keyup", function(){
  const memberPwMsg = document.getElementById("memberPwMsg");
  memberPwMsg.classList.remove(memberPwMsg.classList.item(0));
  memberPwMsg.textContent = "";
  const memberPw = document.getElementById("memberPw").value;
  const pwRegex = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{6,20}$/;//대문자(영어), 소문자(영어), 숫자, 특수문자 각 1개씩 포함하여 6~20자 사이
  if(pwRegex(memberPw)){
    memberPwMsg.classList.add("inputMsg-success");
    memberPwMsg.textContent("사용 가능한 비밀번호입니다.");
  }else{
    memberPwMsg.classList.add("inputMsg-error");
    memberPwMsg.textContent("대문자(영어), 소문자(영어), 숫자, 특수기호를 모두 포함하여 6~20글자 사이");
  }
});

//비밀번호 확인시 비밀번호 일치여부 확인
document.getElementById("memberPwRe").addEventListener("keyup", function(){
  const memberPwReMsg = document.getElementById("memberPwReMsg");
  memberPwReMsg.classList.remove(memberPwReMsg.classList.item(0));
  memberPwReMsg.textContent = "";
  const memberPw = document.getElementById("memberPw").value;
  const memberPwRe = document.getElementById("memberPwRe").value;
  if(memberPw == memberPwRe){
    memberPwReMsg.classList.add("inputMsg-success");
    memberPwReMsg.textContent("비밀번호 일치");
  }else{
    memberPwReMsg.classList.add("inputMsg-error");
    memberPwReMsg.textContent("비밀번호 불일치");
  }
});

//닉네임 제약조건 확인
document.getElementById("checkNickName").addEventListener("click", function(){
  const memberNickNameMsg = document.getElementById("memberNickNameMsg");
  memberNickNameMsg.classList.remove(memberNickNameMsg.classList.item(0));
  memberNickNameMsg.textContent = "";
  const memberNickName = document.getElementById("memberNickName").value;
  const nickNameRegex = /^[가-힣]{2,6}$/;
  if(nickNameRegex(memberNickName)){
    $.ajax({
      method: "get",
      url: "/member/checkNickNameIsDuplicated",
      data: {memberNickName: memberNickName},
      dataType: "json",
      success: function(data){
        if(data.response = "success") {
          memberNickNameMsg.classList.add("inputMsg-success");
          memberNickNameMsg.textContent = "사용 가능한 닉네임입니다.";
        } else {
          memberNickNameMsg.classList.add("inputMsg-error");
          memberNickNameMsg.textContent = "이미 사용중인 닉네임입니다.";
        }
      },
      error: function(data){
        console.log(data);
      }
    })
  }else{
    memberNickNameMsg.classList.add("inputMsg-error");
    memberNickNameMsg.textContent("한글로 2~6글자 사이");
  }
});