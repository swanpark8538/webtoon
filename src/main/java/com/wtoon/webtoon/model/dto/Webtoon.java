package com.wtoon.webtoon.model.dto;

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
	private int webtoonWeeklyviews;
	
	public String getBr() {
		return webtoonIntro.replaceAll("\r\n", "<br>");
	}
}
