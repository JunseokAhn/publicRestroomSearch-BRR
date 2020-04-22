package global.sesoc.brr.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DayAverVO {

	
	private Double lat;
	private Double lng;
	private String toiletnm;
	private String id;
	private String inputdate;
	private Double average;
	private Double differ;
	
	
}
