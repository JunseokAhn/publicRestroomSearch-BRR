package global.sesoc.brr.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class HospitalVO 
{
	private String dutyName;
	private String dutyTel1;
	private String dutyAddr;
	private String dutyTimeS;
	private String dutyTimeC;
	private String dutyTimeSatS;
	private String dutyTimeSatC;
	private String dutyTimeSunS;
	private String dutyTimeSunC;
    private double lat;
    private double lng;    
}
