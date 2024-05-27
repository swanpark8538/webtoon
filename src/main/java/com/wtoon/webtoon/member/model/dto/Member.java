package com.wtoon.webtoon.member.model.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
//alias 설정은 mybatis-config에서 할 것
public class Member {

	private int memberNo;
	private String memberId;			//일반 : ID / 구글 : google_ID / 네이버 : naver_ID / 카카오 : kakao_ID
	private String memberPw;
	private String memberNickName;		//소셜로그인시 중복 안 되도록 "회원 이름_v1" 이런 식으로 자동으로 저장
	private String memberName;
	private String memberEmail;
	private int memberPhone;
	private String memberAddressPrime;
	private String memberAddressDetail;
	private int memberBirthdate;
	private int memberGender;			//2n이면 여성, 2n-1이면 남성.
	private String memberSocial;		//일반 회원가입 : null, 구글 : google, 네이버 : naver, 카카오 : kakao
	private Date regDate;
	private char memberIsBlocked;		//check in / '0' : 차단 X, '1' : 차단 O
	private char adultIsAuthed;			//check in / '0' : 인증 X, '1' : 인증 O
	private char memberIsDeleted;		//check in / '0' : 삭제 X, '1' : 삭제 O
}
