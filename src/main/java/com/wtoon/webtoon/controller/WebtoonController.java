package com.wtoon.webtoon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wtoon.webtoon.util.FileUtils;
import com.wtoon.webtoon.model.dto.Webtoon;
import com.wtoon.webtoon.model.service.WebtoonService;

@Controller
@RequestMapping(value = "/webtoon")
public class WebtoonController {
	@Autowired
	private WebtoonService webtoonService;
	@Autowired
	@Qualifier("fileLocation")
	private String root;
	@Autowired
	private FileUtils fileUtils;
	
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
	
	@PostMapping(value = "/register")
	public String register(Webtoon webtoon, MultipartFile imgFile, 
			int writer, int painter, String[] days, String[] genres, String[] tags) {
		
		
		
		/*
		System.out.println(webtoon);
		System.out.println(imgFile);
		System.out.println(writer);
		System.out.println(painter);
		for (String a : days) {
			System.out.println(a);
		}
		for (String a : genres) {
			System.out.println(a);
		}
		for (String a : tags) {
			System.out.println(a);
		}
		*/
		return "webtoon/myWorksList";
	}
	
}
