package com.wtoon.webtoon.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class EpisodeFile {
	private int fileNo;
	private int epiNo;
	private String fileName;
	private String filePath;
}
