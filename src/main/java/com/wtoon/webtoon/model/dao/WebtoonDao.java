package com.wtoon.webtoon.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
	
}
