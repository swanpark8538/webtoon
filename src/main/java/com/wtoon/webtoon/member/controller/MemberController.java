package com.wtoon.webtoon.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.wtoon.webtoon.member.model.dto.Member;
import com.wtoon.webtoon.member.model.service.MemberService;
import com.wtoon.webtoon.util.CookieUtils;

@Controller
@RequestMapping(value="/member")
public class MemberController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private CookieUtils cookieUtils;
	
	
	//회원가입 양식
	@GetMapping(value="/signUpFrm")
	public String signUpFrm() {
		return "member/signUpFrm";
	}
	
	//아이디 중복 확인
	@ResponseBody
	@GetMapping(value="checkIdIsDuplicated")
	public Map checkId(String memberId){
		Member m = new Member();
		m.setMemberId(memberId);
		Member member = memberService.selectOneMember_BCrypt(m);
		Map map = new HashMap<String, String>();
		if(member != null) {
			map.put("response", "success");//중복X
		}else {
			map.put("response", "fail");//중복O
		}
		return map;
	}
	
	//전화번호 중복 확인
	@ResponseBody
	@GetMapping(value="checkPhoneIsDuplicated")
	public Map checkPhone(int memberPhone) {
		Member member = memberService.checkPhone(memberPhone);
		Map map = new HashMap<String, String>();
		if(member != null) {
			map.put("response", "success");//중복X
		}else {
			map.put("response", "fail");//중복O
		}
		return map;
	}
	
	//닉네임 중복 확인
	@ResponseBody
	@GetMapping(value="checkNicknameIsDuplicated")
	public Map checkNickname(String memberNickname) {
		Member member = memberService.checkNickname(memberNickname);
		Map map = new HashMap<String, String>();
		if(member != null) {
			map.put("response", "success");//중복X
		}else {
			map.put("response", "fail");//중복O
		}
		return map;
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
	public String signIn(Member m, Model model, HttpSession session, HttpServletResponse response,
						@CookieValue(name = "signInFailCount", required = false) String signInFailCount,
						@CookieValue(name = "memberIdArr", required = false) ArrayList<String> memberIdArr) {
		
		Member member = memberService.selectOneMember_BCrypt(m);
		Cookie signInFailCountCookie = new Cookie("signInFailCount", null);
		Cookie memberIdArrCookie = new Cookie("memberIdArr", null);
		int signInFailCountLimit = 5;
		
		if(signInFailCount != null && Integer.parseInt(signInFailCount) == signInFailCountLimit) {
			//로그인 시도 제한에 걸렸을 때
			model.addAttribute("loginIsDenied", true);
			return "redirect:/member/signInFrm";
			
		}else if (member != null) {
			//로그인 성공시
			session.setAttribute("member", member);
			if(signInFailCount != null) {
				signInFailCountCookie.setMaxAge(0);//0밀리초 = 삭제
				response.addCookie(signInFailCountCookie);
			}
			if(memberIdArr != null) {
				memberIdArrCookie.setMaxAge(0);//0밀리초 = 삭제
				response.addCookie(memberIdArrCookie);
			}
			return "redirect:/";
			
		} else {
			//로그인 실패시
			Gson gson = new Gson();
			if(signInFailCount == null) {
				//signInFailCount
				signInFailCountCookie.setValue(Integer.toString(1));
				//memberId
				ArrayList<String> firstMemberIdArr = new ArrayList<String>();
				firstMemberIdArr.add(m.getMemberId());
				memberIdArrCookie.setValue(gson.toJson(firstMemberIdArr));
			} else {
				//signInFailCount
				signInFailCount = Integer.toString(Integer.parseInt(signInFailCount)+1);
				signInFailCountCookie.setValue(signInFailCount);
				//memberId
				memberIdArr.add(m.getMemberId());
				memberIdArrCookie.setValue(gson.toJson(memberIdArr));
			} 
			signInFailCountCookie.setMaxAge(24 * 60 * 60);//24시간
			memberIdArrCookie.setMaxAge(24 * 60 * 60);//24시간
			response.addCookie(signInFailCountCookie);
			response.addCookie(memberIdArrCookie);

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
