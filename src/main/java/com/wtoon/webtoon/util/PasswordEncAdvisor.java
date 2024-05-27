package com.wtoon.webtoon.util;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import com.wtoon.webtoon.member.model.dto.Member;

@Aspect
@Component
public class PasswordEncAdvisor {

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
								//그 메소드의 returnType:*		경로						   //Encrypted로 끝나는 모든메소드(매개변수 Member객체)
	@Pointcut(value="execution (* com.wtoon.webtoon.member.model.service.MemberService.*Encrypted(com.wtoon.webtoon.member.model.dto.Member))")
	public void pwEncPointcut() {}
	
	@Before(value="pwEncPointcut()")
	public void pwEncAdvice(JoinPoint jp) {
		Object[] args = jp.getArgs();//매개변수 가져옴
		Member member = (Member)args[0];//Member객체로 형변환
		String encPw = bCryptPasswordEncoder.encode(member.getMemberPw());//암호화
		member.setMemberPw(encPw);//Member객체의 pw를 암호화한 pw로 변경하여 저장
	}
}
