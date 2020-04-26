package global.sesoc.brr.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TestDataVO 
{
	private String day;
	private double moisture;
	private double stress;
	private double ingredient;
	private int status;    
}
