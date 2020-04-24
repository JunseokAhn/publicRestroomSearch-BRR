package global.sesoc.brr.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewVO {
	private String toiletNm;
	private Double lng;
	private Double lat;
	private String sessionId;
	private String sessionNickname;
	private String Profile;
	private String review;
	private int star;
	private int clean;
	private String inputdate;
}
