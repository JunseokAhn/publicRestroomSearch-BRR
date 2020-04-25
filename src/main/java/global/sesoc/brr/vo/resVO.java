package global.sesoc.brr.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class resVO {
	private String id;
	private double stress;
	private double moisture;
	private double ingredient;
	private int status;
	private String inputdate;
}
