package global.sesoc.brr.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewAverVO {
	
	private Double starAver;
	private Double cleanAver;
	private Double starDiffer;
	private Double cleanDiffer;
		
}
