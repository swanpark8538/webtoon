package com.wtoon.webtoon.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wtoon.webtoon.member.model.dto.Member;
import com.wtoon.webtoon.member.model.service.MemberService;

@Controller
@RequestMapping(value="/member")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	//회원가입 양식
	@GetMapping(value="/signUpFrm")
	public String signUpFrm() {
		return "member/signUpFrm";
	}
	
	@ResponseBody
	@GetMapping(value="checkIdIsDuplicated")
	public String idCheck(String memberId){
		
		Member m = new Member();
		m.setMemberId(memberId);
		Member member = memberService.selectOneMember_BCrypt(m);
		if(member != null) {
			return "success";//중복X
		}else {
			return "fail";//중복O
		}
	}
	
	//회원가입
	@PostMapping(value="/signUp")
	public String insertMember(Member m, Model model) {
		
		int result = memberService.insertMember_BCrypt(m);
		if(result>0) {
			model.addAttribute("title", "회원가입 완료");
			model.addAttribute("msg", "가입을 환영합니다");
			model.addAttribute("icon", "success");
			model.addAttribute("loc", "/");
		}else {
			model.addAttribute("title", "회원가입 실패");
			model.addAttribute("msg", "다시 가입해주세요");
			model.addAttribute("icon", "error");
			model.addAttribute("loc", "/member/signUpFrm");
		}
		return "common/msg";
	}
	
	//로그인 양식
	@GetMapping(value="/signInFrm")
	public String signInFrm() {
		return "member/signInFrm";
	}
	
	//로그인
	@PostMapping(value="/signIn")
	public String signIn(Member m, Model model, HttpSession session) {
		
		Member member = memberService.selectOneMember_BCrypt(m);
		if(member != null) {
			//로그인 성공시 session에 저장된 실패횟수 데이터를 삭제
			session.removeAttribute("signInFailCount");
			session.setAttribute("member", member);
			return "redirect:/";
		} else {
			//로그인 실패시 session에 실패횟수를 저장
			session.setAttribute("signInFailCount",
								 session.getAttribute("signInFailCount") != null
								 	? (Integer)session.getAttribute("signInFailCount")+1
								 	: 1);
			Integer signInFailCountLimit = 5;
			model.addAttribute("signInFailCountLimit", signInFailCountLimit);
			return "redirect:/member/signInFrm";
		}
	}
	
	//로그아웃
	@GetMapping(value="signOut")
	public String signOut(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	

		
	
	
	
}
