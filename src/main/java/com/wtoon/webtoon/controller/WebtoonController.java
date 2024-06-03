package com.wtoon.webtoon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wtoon.webtoon.model.service.WebtoonService;

@Controller
@RequestMapping(value = "/webtoon")
public class WebtoonController {
	@Autowired
	private WebtoonService webtoonService;
	
	@GetMapping(value = "/myWorks")
	public String myWorks(int reqPage, Model model) {
		//내 작품 리스트 불러오기
		
		return "webtoon/myWorksList";
	}
	
	@GetMapping(value = "/regMyWorks")
	public String regMyWorks(Model model) {
		//장르 목록 불러오기
		List list = webtoonService.selectGenreList();
		model.addAttribute("list", list);
		return "webtoon/registerFrm";
	}
	
	@ResponseBody
	@GetMapping(value = "/tagSearch")
	public List tagSearch(String hashtag) {
		return webtoonService.selectTagList(hashtag);
	}
	
	@ResponseBody
	@GetMapping(value = "/searchWriter")
	public List searchWriter(String memberId) {
		return webtoonService.selectWriterList(memberId);
	}
	
}
