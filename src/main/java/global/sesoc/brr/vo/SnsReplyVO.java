package global.sesoc.brr.vo;

import lombok.Data;

@Data
public class SnsReplyVO {
	
	String snsReplynum;			//리플번호
	String snsBoardnum;			//게시글번호
	String id;					//작성자 ID
	String comments;			//리플내용
	String inputdate;			//작성날짜

}
