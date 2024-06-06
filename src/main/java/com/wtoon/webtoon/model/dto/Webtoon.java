package com.wtoon.webtoon.model.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Webtoon {
	private int webtoonNo;
	private String webtoonTitle;
	private String webtoonThumbnail;
	private String webtoonIntro;
	private String webtoonRating;
	private String webtoonIsinseries;
	private String webtoonIsdeleted;
	
	public String getBr() {
		return webtoonIntro.replaceAll("\r\n", "<br>");
	}
	
	private Creator writer;
	private Creator painter;
	private List<String> hashtag;
	private List<String> day;
	private List<String> genre;
	private String avgRating;	//평균별점
	
	
}
