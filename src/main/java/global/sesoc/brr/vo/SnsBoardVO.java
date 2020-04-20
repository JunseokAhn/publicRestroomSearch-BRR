package global.sesoc.brr.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor // 모든 필드 값을 파라미터로 받는 생성자 생성
@NoArgsConstructor // 파라미터가 없는 기본 생성자 생성
public class SnsBoardVO {

	private String snsBoardnum;		//게시판 글번호
	private String id;				//작성자ID
	private String email;			//작성자email
	private String title;			//제목
	private String contents;		//내용
	private String inputdate;		//작성일
	private String originalfile;	//첨부파일 원래이름	
	private String savedfile;		//첨부파일 저장된이름
	
}
