package com.wtoon.webtoon.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtoon.webtoon.model.dto.Webtoon;

@Repository
public class WebtoonDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public List selectGenreList() {
		return session.selectList("webtoon.selectGenreList");
	}

	public List selectTagList(String hashtag) {
		return session.selectList("webtoon.selectTagList",hashtag);
	}

	public List selectWriterList(String memberId) {
		return session.selectList("webtoon.selectWriterList",memberId);
	}

	public int insertWebtoon(Webtoon webtoon) {
		return session.insert("webtoon.insertWebtoon", webtoon);
	}

	public int insertCreator(HashMap<String, Object> map) {
		return session.insert("webtoon.insertCreator", map);
	}

	public int insertDay(HashMap<String, Object> map) {
		return session.insert("webtoon.insertDay", map);
	}

	public int insertGenre(HashMap<String, Object> map) {
		return session.insert("webtoon.insertGenre", map);
	}

	public int insertTag(HashMap<String, Object> map) {
		return session.insert("webtoon.insertTag", map);
	}



	
	
}
