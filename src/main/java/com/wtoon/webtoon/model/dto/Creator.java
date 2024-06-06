package com.wtoon.webtoon.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Creator {
	private int memberNo;
	private int webtoonNo;
	private String memberId;
	private String memberNickname;	
	private String creatorType;
}
