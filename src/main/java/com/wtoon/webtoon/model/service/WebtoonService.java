package com.wtoon.webtoon.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wtoon.webtoon.model.dao.WebtoonDao;

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
	
	
}
