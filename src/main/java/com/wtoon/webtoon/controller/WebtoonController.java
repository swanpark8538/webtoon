package com.wtoon.webtoon.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wtoon.webtoon.util.FileUtils;
import com.wtoon.webtoon.model.dto.WorkPageData;
import com.wtoon.webtoon.member.model.dto.Member;
import com.wtoon.webtoon.model.dto.EpiPageData;
import com.wtoon.webtoon.model.dto.Episode;
import com.wtoon.webtoon.model.dto.EpisodeFile;
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

	//메인 웹툰 리스트 불러오기
	@GetMapping()
	public String tab(String tab, Model model) {
		model.addAttribute("tab", tab);
		return "webtoon/webtoonList";
	}
	
	@ResponseBody
	@GetMapping(value="/list")
	public List list(String tab, String sort, String genre, Model model) {
		List list = webtoonService.selectWebtoonList(tab, sort, genre);
		return list;
	}
	
	@GetMapping(value = "/myWorks")
	public String myWorks(int reqPage, Model model, int type) {
		//내 작품 리스트 불러오기
		//로그인 구현시 세션에서 멤버번호가져와서 변경 예정
		int memberNo = -1;
		//System.out.println(memberNo);
		WorkPageData wpd = webtoonService.getMyWorksList(reqPage,memberNo,type);
		model.addAttribute("list", wpd.getList());
		model.addAttribute("pageNavi", wpd.getPageNavi());
		model.addAttribute("totalCount", wpd.getTotalCount());
		model.addAttribute("type",type);
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
		
		//System.out.println(result);
		//System.out.println(totalCount);
		
		if(result==totalCount) {
			model.addAttribute("title", "작품 등록 완료");
			model.addAttribute("msg", "작품이 등록되었습니다.");
			model.addAttribute("icon", "success");
			model.addAttribute("loc", "/webtoon/myWorks?reqPage=1&type=1");
		}else {
			model.addAttribute("title", "작품 등록 실패");
			model.addAttribute("msg", "다시 등록해주세요.");
			model.addAttribute("icon", "error");
			model.addAttribute("loc", "/webtoon/myWorks?reqPage=1&type=1");
		}
		return "common/msg";
	}

	
	@GetMapping(value = "/delete")
	public String deleteWebtoon(int webtoonNo, Model model) {
		int result = webtoonService.deleteWebtoon(webtoonNo);
		if(result>0) {
			model.addAttribute("title", "작품 삭제 완료");
			model.addAttribute("msg", "작품이 삭제되었습니다.");
			model.addAttribute("icon", "success");
			model.addAttribute("loc", "/webtoon/myWorks?reqPage=1&type=1");
		}else {
			model.addAttribute("title", "작품 삭제 실패");
			model.addAttribute("msg", "다시 시도해주세요.");
			model.addAttribute("icon", "error");
			model.addAttribute("loc", "/webtoon/myWorks?reqPage=1&type=1");
		}
		return "common/msg";
	}
	
	@GetMapping(value = "/editMyWork")
	public String editMyWork(Model model, int webtoonNo) {
		//작품정보 가져오기
		Webtoon webtoon = webtoonService.getMyWork(webtoonNo);
		List list = webtoonService.selectGenreList();	//장르목록
		//System.out.println(webtoon);
		model.addAttribute("list", list);
		model.addAttribute("w", webtoon);
		return "/webtoon/editMyWork";
	}
	
	@PostMapping(value = "/edit")
	public String edit(Model model, Webtoon webtoon, MultipartFile newImgFile, String oldImgFile,
			int writer, int painter, String[] days, int[] genres, String[] tags, String[] delTags, String[] status) {
		//전체 삭제 후 재등록 : 요일, 장르, 태그
		//사진은 새 파일 있으면 변경 아니면 원래꺼로 설정 해준 뒤 웹툰정보, 작가들은 수정
		System.out.println(webtoon);
		if(status!=null) {
			if(status[0].equals("2")) {
				System.out.println("휴재중");
				webtoon.setWebtoonIsinseries("2");
			}else if(status[0].equals("0")) {
				System.out.println("완결");
				webtoon.setWebtoonIsinseries("0");
			}
		}else {
			webtoon.setWebtoonIsinseries("1");
		}
		if (newImgFile != null && !newImgFile.isEmpty()) {//파일이 있으면
			String savepath = root+"/webtoon/";
			fileUtils.deleteFile(savepath, oldImgFile);
			String filepath = fileUtils.upload(savepath, newImgFile);
			webtoon.setWebtoonThumbnail(filepath);
		}else {	//없으면
			webtoon.setWebtoonThumbnail(oldImgFile);
		}
		System.out.println(webtoon);
		int result = webtoonService.edit(webtoon,writer,painter,days,genres,tags,delTags);
		int totalCount = 3 + days.length + genres.length + (tags != null ? tags.length : 0) + (delTags != null ? delTags.length : 0);
		System.out.println("결과: "+ result);
		System.out.println("계산수: "+ totalCount);	
		if(result==totalCount) {
			model.addAttribute("title", "작품 수정 완료");
			model.addAttribute("msg", "작품이 수정되었습니다.");
			model.addAttribute("icon", "success");
			model.addAttribute("loc", "/webtoon/myWorks?reqPage=1&type=1");
		}else {
			model.addAttribute("title", "작품 수정 실패");
			model.addAttribute("msg", "다시 시도해주세요.");
			model.addAttribute("icon", "error");
			model.addAttribute("loc", "/webtoon/myWorks?reqPage=1&type=1");
		}
		return "common/msg";
	}
	
	@GetMapping(value = "/manageEpi")
	public String manageEpi(int webtoonNo,Model model){
		//웹툰 정보 + 회차 리스트 + 페이징
		//EpiPageData epd = webtoonService.selectEpiList(webtoonNo);
		model.addAttribute("webtoonNo", webtoonNo);		//수정예정
		return "/webtoon/manageEpi";
	}
	
	@GetMapping(value = "/newEpisode")
	public String newEpisode(int webtoonNo, Model model){
		//웹툰명,회차번호 가져오기
		HashMap<String, Object> map = webtoonService.selectEpiNo(webtoonNo);
		model.addAttribute("webtoonNo",webtoonNo);
		model.addAttribute("epiNo",map.get("epiNo"));
		model.addAttribute("webtoonTitle",map.get("webtoonTitle"));
		return "/webtoon/regEpisode";
	}
	
	@ResponseBody
	@PostMapping(value = "/regEpisode",produces="plain/text;charset=utf-8")
	public String regEpisode( 
			MultipartFile imgFile, MultipartFile[] epiFiles,
			int epiOpen, Episode epi) {
		System.out.println(epiOpen);
		if(epiOpen==1) {
			epi.setEpiOpenDate("");
		}
		System.out.println(epi);		
		//썸네일
		String savepath = root+"/webtoon/episode/";
		String filepath = fileUtils.upload(savepath, imgFile);
		epi.setEpiThumbnail(filepath);
		
		//원고파일
		ArrayList<EpisodeFile> episodeFileList = new ArrayList<EpisodeFile>();
		if(epiFiles != null && epiFiles.length > 0 && !epiFiles[0].isEmpty()) {
			String epiSavepath = root+"/webtoon/episode/";
			for(MultipartFile file:epiFiles) {
				String epiFilename = file.getOriginalFilename();
				String epiFilepath = fileUtils.upload(epiSavepath, file);
				EpisodeFile episodeFile = new EpisodeFile();
				episodeFile.setFileName(epiFilename);
				episodeFile.setFilePath(epiFilepath);
				episodeFileList.add(episodeFile);
				//System.out.println(epiFilepath);
			}
		}
		epi.setEpisodeFile(episodeFileList);
		int result = webtoonService.insertEpi(epi);
		if(result == 1 + episodeFileList.size()) {
			return "1";	//성공
		}else {
			return "0";	//실패
		}
		
		/*
		System.out.println("컨트롤러부분");
		System.out.println(imgFile);
		System.out.println(epi);
		System.out.println(epiFiles);
		
		//System.out.println(openDate);
		*/
	}
	
	//회차별 상세 페이지
	@GetMapping(value="/episode")
	public String episodeDetail(String tab, int webtoonNo, int reqNo, @SessionAttribute(name="member", required=false) Member sessionMember, Model model) {
		//로그인 구현시 세션에서 멤버 가져와서 변경 예정
		String memberId = "haeun";
		Episode episode = webtoonService.selectEpisodeDetail(webtoonNo, reqNo);
		System.out.println(episode);
		int commentCount = webtoonService.selectCommentCount(episode.getEpiNo());
		model.addAttribute("memberId", memberId);
		model.addAttribute("tab", tab);
		model.addAttribute("episode", episode);
		model.addAttribute("commentCount", commentCount);
		return "/webtoon/episodeDetail";
	}
	//회차별 상세 댓글
	@ResponseBody
	@GetMapping(value="/episodeComment")
	public List commentList(int epiNo, int start, int amount) {
		List commentList = webtoonService.selectCommentList(epiNo, start, amount);
		return commentList;
	}
	//스크롤값 전달
	@ResponseBody
	@GetMapping(value="/insertViewPercent")
	public void insertViewPercent(int webtoonNo, int epiNo, int viewPercent, @SessionAttribute(name="member", required=false) Member sessionMember) {
		//로그인 구현시 세션에서 멤버번호가져와서 변경 예정
		int memberNo = -1;
		System.out.println(viewPercent);
		System.out.println(sessionMember);
		webtoonService.insertRecentView(memberNo, webtoonNo, epiNo, viewPercent);
	}
	
}
