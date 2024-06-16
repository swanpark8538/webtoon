package com.wtoon.webtoon.model.dto;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

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
	private int serialDay;

	
	public String getBr() {
		return webtoonIntro.replaceAll("\r\n", "<br>");
	}
	
	private Creator creator1;
	private Creator creator2;
	private String writerStr;
	private String painterStr;
	
	private List<String> hashtag;
	private List<String> day; //연재요일
	private List<String> genre;
	private double avgRating;	//평균별점
	
    // 요일 번호와 요일 이름 매핑
    private static final Map<String, String> DAY_MAP = Stream.of(new String[][] {
        { "0", "일" },
        { "1", "월" },
        { "2", "화" },
        { "3", "수" },
        { "4", "목" },
        { "5", "금" },
        { "6", "토" },
    }).collect(Collectors.toMap(data -> data[0], data -> data[1]));

    public String getDayDescription() {
        if (day == null || day.isEmpty()) {
            return "";
        }
        return day.stream()
                  .map(DAY_MAP::get)
                  .collect(Collectors.joining(", "));
    }
	
}
