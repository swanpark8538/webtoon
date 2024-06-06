package com.wtoon.webtoon.model.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtoon.webtoon.model.dao.WebtoonDao;
import com.wtoon.webtoon.model.dto.PageData;
import com.wtoon.webtoon.model.dto.Webtoon;

@Service
public class WebtoonService {
	@Autowired
	private WebtoonDao webtoonDao;

	public List selectGenreList() {
		return webtoonDao.selectGenreList();
	}

	public List selectTagList(String hashtag) {
		return webtoonDao.selectTagList(hashtag);
	}

	public List selectWriterList(String memberId) {
		return webtoonDao.selectWriterList(memberId);
	}
	
	@Transactional
	public int insertWebtoon(Webtoon webtoon, int writer, int painter, String[] days, int[] genres, String[] tags) {
		//웹툰 -> 등록 후 등록된 웹툰 번호 등록해줌
		int result = webtoonDao.insertWebtoon(webtoon);
		int webtoonNo = webtoon.getWebtoonNo();
		//글 작가, 그림 작가
		HashMap<String, Object> writerMap = new HashMap<String, Object>();
		writerMap.put("memberNo", writer);
		writerMap.put("webtoonNo", webtoonNo);
		writerMap.put("creatorType", "1");
		HashMap<String, Object> painterMap = new HashMap<String, Object>();
		painterMap.put("memberNo", painter);
		painterMap.put("webtoonNo", webtoonNo);
		painterMap.put("creatorType", "2");
		result += webtoonDao.insertCreator(writerMap);
		result += webtoonDao.insertCreator(painterMap);
		//연재요일
		for(String day :days) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("webtoonNo", webtoonNo);
			map.put("serialDay", day);
			result+=webtoonDao.insertDay(map);
		}
		//장르
		for(int genre :genres) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("webtoonNo", webtoonNo);
			map.put("genreNo", genre);
			result+=webtoonDao.insertGenre(map);
		}
		//태그
		if(tags!=null) {
			for(String tag: tags) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("webtoonNo", webtoonNo);
				map.put("hashTag", tag);
				result+=webtoonDao.insertTag(map);
			}
		}
		return result;
	}

	public int deleteWebtoon(int webtoonNo) {
		return webtoonDao.deleteWebtoon(webtoonNo);
	}

	public PageData getMyWorksList(int reqPage, int memberNo) {
		int numPerPage = 10;
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("memberNo", memberNo);
		List list = webtoonDao.getMyWorksList(map);
		System.out.println(numPerPage);
		System.out.println(list);
		int totalCount = webtoonDao.totalMyWorksCount(memberNo);
		int totalPage = totalCount%numPerPage == 0 ? totalCount/numPerPage : totalCount/numPerPage + 1;
		
		int pageNaviSize = 10;
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize + 1;
		String pageNavi = "";
		if(pageNo != 1) {
			pageNavi = "<a href='/webtoon/myWorks?reqPage="+(pageNo-1)+"'>[이전]</a>";
		}
		for(int i=0; i<pageNaviSize; i++) {
			if(reqPage == pageNo) {
				pageNavi += "<span>"+pageNo+"</span>";				
			}else {
				pageNavi += "<a href='/webtoon/myWorks?reqPage="+pageNo+"'>"+pageNo+"</a>";				
			}
			pageNo++;
			if(pageNo > totalPage) {
				break;
			}
		}
		if(pageNo <= totalPage) {
			pageNavi += "<a href='/webtoon/myWorks?reqPage="+pageNo+"'>[다음]</a>";
		}
		PageData pd = new PageData(list,pageNavi);
		return pd;
	}
	
	
}
