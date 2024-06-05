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
		//내 작품 리스트 불러오기,페이지
		
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
	public String register(Model model, Webtoon webtoon, MultipartFile imgFile, 
		int writer, int painter, String[] days, int[] genres, String[] tags) {
		//웹툰 썸네일 등록
		String savepath = root+"/webtoon/";
		String filepath = fileUtils.upload(savepath, imgFile);
		webtoon.setWebtoonThumbnail(filepath);

		int result = webtoonService.insertWebtoon(webtoon,writer,painter,days,genres,tags);
		int tagCount = 0;
		if(tags!=null) {
			tagCount = tags.length;
		}
		int totalCount = 1+1+1+days.length+genres.length+tagCount;
		
		System.out.println(result);
		System.out.println(totalCount);
		
		if(result==totalCount) {
			model.addAttribute("title", "작품 등록 완료");
			model.addAttribute("msg", "작품이 등록되었습니다.");
			model.addAttribute("icon", "success");
			model.addAttribute("loc", "/webtoon/myWorks?reqPage=1");
		}else {
			model.addAttribute("title", "작품 등록 실패");
			model.addAttribute("msg", "다시 등록해주세요.");
			model.addAttribute("icon", "error");
			model.addAttribute("loc", "/webtoon/myWorks?reqPage=1");
		}
		return "common/msg";
	}
	
}
