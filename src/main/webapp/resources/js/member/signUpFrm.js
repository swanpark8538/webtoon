//아이디 제약조건 확인 + 중복 확인
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
  const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{6,20}$/;//영어(1글자 이상 필수), 숫자(1글자 이상 필수), 특수문자(선택사항)를 포함하여 6~20자 사이
  if(pwRegex.test(memberPw)){
    memberPwMsg.classList.add("inputMsg-success");
    memberPwMsg.textContent = "사용 가능한 비밀번호입니다.";
  }else{
    memberPwMsg.classList.add("inputMsg-error");
    memberPwMsg.textContent = "영어, 숫자를 반드시 포함하여 6~20글자 사이";
  }
});

//비밀번호 일치여부 확인
document.getElementById("memberPwRe").addEventListener("keyup", function(){
  const memberPwReMsg = document.getElementById("memberPwReMsg");
  memberPwReMsg.classList.remove(memberPwReMsg.classList.item(0));
  memberPwReMsg.textContent = "";
  const memberPw = document.getElementById("memberPw").value;
  const memberPwRe = document.getElementById("memberPwRe").value;
  if(memberPw == memberPwRe){
    memberPwReMsg.classList.add("inputMsg-success");
    memberPwReMsg.textContent = "비밀번호 일치";
  }else{
    memberPwReMsg.classList.add("inputMsg-error");
    memberPwReMsg.textContent = "비밀번호 불일치";
  }
});

//닉네임 제약조건 확인 + 중복 확인
document.getElementById("checkNickname").addEventListener("click", function(){
  const memberNicknameMsg = document.getElementById("memberNicknameMsg");
  memberNicknameMsg.classList.remove(memberNicknameMsg.classList.item(0));
  memberNicknameMsg.textContent = "";
  const memberNickname = document.getElementById("memberNickname").value;
  const nicknameRegex = /^[A-Za-z0-9가-힣]{2,12}$/;
  if(nicknameRegex.test(memberNickname)){
    $.ajax({
      method: "get",
      url: "/member/checkNicknameIsDuplicated",
      data: {memberNickname: memberNickname},
      dataType: "json",
      success: function(data){
        if(data.response = "success") {
          memberNicknameMsg.classList.add("inputMsg-success");
          memberNicknameMsg.textContent = "사용 가능한 닉네임입니다.";
        } else {
          memberNicknameMsg.classList.add("inputMsg-error");
          memberNicknameMsg.textContent = "이미 사용중인 닉네임입니다.";
        }
      },
      error: function(data){
        console.log(data);
      }
    })
  }else{
    memberNicknameMsg.classList.add("inputMsg-error");
    memberNicknameMsg.textContent = "2~20글자 사이를 입력해주세요.";
  }
});

//이메일 제약조건 확인 + 카카오 주소 API 활용

//전화번호 제약조건 확인 + 전화번호 본인인증
document.getElementById("authPhone").addEventListener("click", function(){
  const memberPhoneMsg = document.getElementById("memberPhoneMsg");
  memberPhoneMsg.classList.remove(memberPhoneMsg.classList.item(0));
  memberPhoneMsg.textContent = "";
  const memberPhone = document.getElementById("memberPhone");
  const phoneRegex = /^\d{10,11}$/;
  if(phoneRegex.test(memberPhone)){
    //전화번호 중복확인
    $.ajax({
      method: "get",
      url: "/member/checkPhoneIsDuplicated",
      data: {memberPhone: memberPhone},
      dataType: "json",
      success: function(data){
        if(data.response = "success") {
          //여기에 본인인증 API 실행
        } else {
          memberNickNameMsg.classList.add("inputMsg-error");
          memberNickNameMsg.textContent = "이미 사용중인 전화번호입니다.";
        }
      },
      error: function(data){
        console.log(data);
      }
    })
  } else {
    memberPhoneMsg.classList.add("inputMsg-error");
    memberPhoneMsg.textContent = "숫자만으로 정확히 입력해주세요.";
  }
})

//생년월일 제약조건 확인
document.getElementById("memberBirthdate").addEventListener("change", function(){
  const memberBirthdateMsg = document.getElementById("memberBirthdateMsg");
  memberBirthdateMsg.classList.remove(memberBirthdateMsg.classList.item(0));
  memberBirthdateMsg.textContent = "";
  const memberBirthdate = document.getElementById("memberBirthdate").value;
  const birthdateRegex = /^(?:\d{2}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01]))$/;
  if(!birthdateRegex.test(memberBirthdate)){
    memberBirthdateMsg.classList.add("inputMsg-error");
    memberBirthdateMsg.textContent = "잘못 입력했습니다.";
  }
})

//성별 제약조건 확인
document.getElementById("memberGender").addEventListener("keyup", function(){
  const memberGenderMsg = document.getElementById("memberGenderMsg");
  memberGenderMsg.classList.remove(memberGenderMsg.classList.item(0));
  memberGenderMsg.textContent = "";
  const memberGender = document.getElementById("memberGender").value;
  const GenderRegex = /^\d{1}$/;
  if(!GenderRegex.test(memberGender)){
    memberGenderMsg.classList.add("inputMsg-error");
    memberGenderMsg.textContent = "정수를 입력해주세요.";
  }
})