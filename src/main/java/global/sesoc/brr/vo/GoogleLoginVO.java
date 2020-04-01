package global.sesoc.brr.vo;

import global.sesoc.brr.vo.GoogleLoginVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GoogleLoginVO {
	
	
	private String id;
	private String email;
	private String name;
	private String picture;
	private String gender;
	private String age;
	
}
