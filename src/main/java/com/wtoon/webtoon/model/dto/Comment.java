package com.wtoon.webtoon.model.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Comment {
	private int commentNo;
	private int epiNo;
	private String commentWriter;
	private String commentContent;
	private String commentDate;
	private int commentRef;
	private int likeCount;
	private List<Comment> recommentList;
}
