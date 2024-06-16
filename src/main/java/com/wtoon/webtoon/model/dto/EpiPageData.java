package com.wtoon.webtoon.model.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class EpiPageData {
	private Webtoon webtoon;
	private List list;	//회차 리스트
	private String pageNavi;
	private int totalCount;//애피소드 총 갯수
}
