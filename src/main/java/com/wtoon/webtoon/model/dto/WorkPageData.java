package com.wtoon.webtoon.model.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class WorkPageData {
	private List list;
	private String pageNavi;
	private int totalCount;
}
