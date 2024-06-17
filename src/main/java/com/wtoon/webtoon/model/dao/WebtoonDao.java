package com.wtoon.webtoon.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtoon.webtoon.model.dto.Creator;
import com.wtoon.webtoon.model.dto.Episode;
import com.wtoon.webtoon.model.dto.EpisodeFile;
import com.wtoon.webtoon.model.dto.Webtoon;

@Repository
public class WebtoonDao {
	@Autowired
	private SqlSessionTemplate session;

	public List getWebtoonList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return session.selectList("webtoon.getWebtoonList", map);
	}
	
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

	public int deleteWebtoon(int webtoonNo) {
		return session.update("webtoon.deleteWebtoon", webtoonNo);
	}

	public List getMyWorksList(HashMap<String, Object> map) {
		return session.selectList("webtoon.selectMyWorksList", map);
	}

	public int totalMyWorksCount(int memberNo) {
		return session.selectOne("webtoon.selectMyWorksCount", memberNo);
	}

	public Webtoon getMyWork(int webtoonNo) {
		return session.selectOne("webtoon.selectMyWork", webtoonNo);
	}
	
	public int updateMyWork(Webtoon webtoon) {
		return session.update("webtoon.updateMyWork", webtoon);
	}

	public int updateCreator(Creator creator) {
		return session.update("webtoon.updateCreator", creator);
	}

	public int selectDaysCount(int webtoonNo) {
		return session.selectOne("webtoon.selectDaysCount", webtoonNo);
	}

	public int deleteDays(int webtoonNo) {
		return session.delete("webtoon.deleteDays", webtoonNo);
	}

	public int selectGenresCount(int webtoonNo) {
		return session.selectOne("webtoon.selectGenresCount", webtoonNo);
	}

	public int deleteGenres(int webtoonNo) {
		return session.delete("webtoon.deleteGenres", webtoonNo);
	}

	public int deleteTags(HashMap<String, Object> map) {
		return session.delete("webtoon.deleteTags", map);
	}

	public int selectEpiNo(int webtoonNo) {
		return session.selectOne("webtoon.selectEpiNo",webtoonNo);
	}

	public String selectWebtoonTitle(int webtoonNo) {
		return session.selectOne("webtoon.selectWebtoonTitle",webtoonNo);
	}

	public int insertEpi(Episode epi) {
		return session.insert("webtoon.insertEpi", epi);
	}

	public int insertEpiFile(EpisodeFile file) {
		return session.insert("webtoon.insertEpiFile", file);
	}



	
	
}
