package global.sesoc.brr.vo;

import global.sesoc.brr.vo.GoogleVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GoogleVO {
	
	
	private String id;
	private String email;
	private String name;
	private String picture;
	private String gender;
	private String age;
	
}
