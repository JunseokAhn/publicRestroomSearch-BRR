package global.sesoc.brr.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class resVO {
	private int resnum; //
	private int status;  // 결과상태
	private Date inputdate; //sysdate
	private int resvalue; // 결과조회를 위한 벨류값추가 
}
