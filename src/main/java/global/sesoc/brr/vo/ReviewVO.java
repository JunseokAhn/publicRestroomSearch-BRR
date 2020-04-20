package global.sesoc.brr.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewVO {
	private String toilet_title;
	private String sessionId;
	private String nickname;
	private String pictureUrl;
	private String profile_image;
	private String review;
	private int star;
	private int clean;
}
