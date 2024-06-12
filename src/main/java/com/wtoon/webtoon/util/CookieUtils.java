package com.wtoon.webtoon.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

@Component
public class CookieUtils {
	
	private Cookie[] cookies;
	private Cookie cookie;
	
	//쿠키는 name : value 형태임. 즉 map의 key : value와 유사.

	public CookieUtils() {
		// TODO Auto-generated constructor stub
	}
	
	// 객체 생성시에 request 객체를 받는 경우
	public CookieUtils(HttpServletRequest request) {
		this.cookies = request.getCookies();
	}
		
    // 쿠키이름으로 쿠키 값을 얻는 메소드
	public String getValue(String name) {
		for(int i = 0; i < this.cookies.length; i++) {
			if(cookies[i].getName().equals(name)) {
				return cookies[i].getValue();
			}
		}
		return null;
	}
    
    // 쿠키 추가하는 메서드
	public CookieUtils addCookie(String name, String value) {
		this.cookie = new Cookie(name, value);
		return this;
	}
	
 	// 쿠키 추가후에 쿠키 만료일을 체이닝하는 메서드
	public CookieUtils setMaxAge(int period) {
		this.cookie.setMaxAge(period);
		return this;
	}
	
    // 쿠키 추가후에 HttpOnly 옵션을 체이닝하는 메서드 - servlet api 3.0 이상부터 지원
	/*
	public CookieUtils setHttpOnly(boolean setHttpOnly) {
		this.cookie.setHttpOnly(setHttpOnly);
		return this;
	}
	*/
	
    // 쿠키 생성을 마칠 때, 쿠키를 리턴하는 메서드
	public Cookie build() {
		return this.cookie;
	}
	
	//사용 예시
	/*
	response.addCookie(cookieUtils
					.addCookie("refreshToken", refreshToken)
					.setHttpOnly(true)
					.setMaxAge(60 * 60 * 8)
					.build());
	*/
}
