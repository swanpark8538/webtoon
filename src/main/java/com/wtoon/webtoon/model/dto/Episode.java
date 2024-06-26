package com.wtoon.webtoon.model.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Episode {
	private int epiNo;
	private int webtoonNo;
	private String epiTitle;
	private String epiThumbnail;
	private String epiMessage;
	private String epiRegDate;
	private String epiOpenDate;
	private int readCount;
	private String epiIsfree;
	private int realEpiNo;
	private int firstEpiNo;
	private int newestEpiNo;
	private List<EpisodeFile> episodeFile;
	private List<Comment> commentList;
	
	public String getBr() {
		return epiMessage.replaceAll("\r\n", "<br>");
	}
	
}



