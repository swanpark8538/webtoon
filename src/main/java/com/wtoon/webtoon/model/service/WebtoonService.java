package com.wtoon.webtoon.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtoon.webtoon.model.dao.WebtoonDao;
import com.wtoon.webtoon.model.dto.Creator;
import com.wtoon.webtoon.model.dto.Episode;
import com.wtoon.webtoon.model.dto.EpisodeFile;
import com.wtoon.webtoon.model.dto.Webtoon;
import com.wtoon.webtoon.model.dto.WorkPageData;

@Service
public class WebtoonService {
	@Autowired
	private WebtoonDao webtoonDao;

	//메인 웹툰 리스트 불러오기
	public List selectWebtoonList(String tab, String sort, String genre) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("tab", tab);
		map.put("sort", sort);
		map.put("genre", genre);
		return webtoonDao.selectWebtoonList(map);
	}
	
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
				map.put("hashtag", tag);
				result+=webtoonDao.insertTag(map);
			}
		}
		return result;
	}
	
	@Transactional
	public int deleteWebtoon(int webtoonNo) {
		return webtoonDao.deleteWebtoon(webtoonNo);
	}

	public WorkPageData getMyWorksList(int reqPage, int memberNo, int type) {
		int numPerPage = 10;//테스트용 값
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("memberNo", memberNo);
		map.put("type",type);
		List list = webtoonDao.getMyWorksList(map);
		//System.out.println(list);
		int totalCount = webtoonDao.totalMyWorksCount(memberNo);
		int totalPage = totalCount%numPerPage == 0 ? totalCount/numPerPage : totalCount/numPerPage + 1;		
		int pageNaviSize = 5;
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize + 1;
		String pageNavi = "";
		if(pageNo != 1) {
			pageNavi = "<a href='/webtoon/myWorks?reqPage="+(pageNo-1)+"&type="+type+"'>[이전]</a>";
		}
		for(int i=0; i<pageNaviSize; i++) {
			if(reqPage == pageNo) {
				pageNavi += "<span>"+pageNo+"</span>";				
			}else {
				pageNavi += "<a href='/webtoon/myWorks?reqPage="+pageNo+"&type="+type+"'>"+pageNo+"</a>";				
			}
			pageNo++;
			if(pageNo > totalPage) {
				break;
			}
		}
		if(pageNo <= totalPage) {
			pageNavi += "<a href='/webtoon/myWorks?reqPage="+pageNo+"&type="+type+"'>[다음]</a>";
		}
		WorkPageData wpd = new WorkPageData(list,pageNavi,totalCount);
		return wpd;
	}

	public Webtoon getMyWork(int webtoonNo) {
		return webtoonDao.getMyWork(webtoonNo);
	}
	
	@Transactional
	public int edit(Webtoon webtoon, int writer, int painter, String[] days, int[] genres, String[] tags,
			String[] delTags) {
		//웹툰 -> 변경
		int result = webtoonDao.updateMyWork(webtoon);
		if(result>0) {
			int webtoonNo = webtoon.getWebtoonNo();
			//글 작가, 그림 작가 변경
			Creator w = new Creator(writer, webtoonNo, null, null, "1");
			Creator p = new Creator(painter, webtoonNo, null, null, "2");		
			result += webtoonDao.updateCreator(w);
			result += webtoonDao.updateCreator(p);
			//연재요일 => 전체 삭제 후 새로 추가
			int beforeDaysCount = webtoonDao.selectDaysCount(webtoonNo);
			int delDaysCount = webtoonDao.deleteDays(webtoonNo);
			result += delDaysCount;
			if(beforeDaysCount == delDaysCount) { 	//삭제 전 갯수 확인 수 결과에서 빼줌
				result -= beforeDaysCount;			
			}
			for(String day : days) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("webtoonNo", webtoonNo);
				map.put("serialDay", day);
				result+=webtoonDao.insertDay(map);
			}
			//장르 => 전체 삭제 후 새로 추가
			int beforeGenresCount = webtoonDao.selectGenresCount(webtoonNo);
			int delGenresCount = webtoonDao.deleteGenres(webtoonNo);
			result += delGenresCount;
			if(beforeGenresCount==delGenresCount) {
				result -= delGenresCount;
			}
			for(int genre : genres) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("webtoonNo", webtoonNo);
				map.put("genreNo", genre);
				result+=webtoonDao.insertGenre(map);
			}		
			//태그 => delTags 삭제, tags 추가
			if(delTags!=null) {
				for(String delTag : delTags) {
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("webtoonNo", webtoonNo);
					map.put("hashtag", delTag);
					result += webtoonDao.deleteTags(map);					
				}		
			}
			if(tags!=null) {
				for(String tag: tags) {
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("webtoonNo", webtoonNo);
					map.put("hashtag", tag);
					result+=webtoonDao.insertTag(map);
				}
			}
		}
		return result;
	}


	public HashMap<String, Object> selectEpiNo(int webtoonNo) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int epiNo = webtoonDao.selectEpiNo(webtoonNo)+1;
		map.put("epiNo", epiNo);
		String webtoonTitle = webtoonDao.selectWebtoonTitle(webtoonNo);
		map.put("webtoonTitle",webtoonTitle);
		return map;
	}
	
	@Transactional
	public int insertEpi(Episode epi) {
		int result = webtoonDao.insertEpi(epi);
		if(result>0) {
			for(EpisodeFile file:epi.getEpisodeFile()) {
				file.setEpiNo(epi.getEpiNo());
				result += webtoonDao.insertEpiFile(file);
			}
		}
		return result;
	}

	public Episode selectEpisodeDetail(int webtoonNo, int reqNo) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("webtoonNo", webtoonNo);
		map.put("reqNo", reqNo);
		Episode episode = webtoonDao.selectEpisodeDetail(map);
		return episode;
	}

	public int selectCommentCount(int epiNo) {
		return webtoonDao.selectCommentCount(epiNo);
	}
	
	public List selectCommentList(int epiNo, int start, int amount) {
		int end = start+amount-1;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("epiNo", epiNo);
		map.put("start", start);
		map.put("end", end);
		List commentList = webtoonDao.selectCommentList(map);
		return commentList;
	}

	public void insertRecentView(int memberNo, int webtoonNo, int epiNo, int viewPercent) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("memberNo", memberNo);
		map.put("webtoonNo", webtoonNo);
		map.put("epiNo", epiNo);
		map.put("viewPercent", viewPercent);
		int isRecentView = webtoonDao.selectRecentView(map);
		if(isRecentView > 0) {
			webtoonDao.updateRecentView(map);
		}else {
			webtoonDao.insertRecentView(map);			
		}
	}

}