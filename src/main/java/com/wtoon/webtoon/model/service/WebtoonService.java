package com.wtoon.webtoon.model.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtoon.webtoon.model.dao.WebtoonDao;
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
	
	
}
