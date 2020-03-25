package global.sesoc.brr.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ToiletVO 
{	
	private String toiletNm; // 화장실 이름
    private String toiletType;  // 화장실 타입  개방 or 공중
    private String lnmadr; // 화장실 주소
    private String unisexToiletYn; //남녀공용화장실 여부
    private int menToiletBowl; //남성용 대변기 수
    private int menUrineNumber; // 남성용-소변기수
    private int menHandicapToiletBowl; //남성용-장애인용대변기수
    private int menHandicapUrinal; //남성용-장애인용소변기수
    private int menChildrenToiletBowl; //남성용-어린이용대변기수
    private int menChildrenUrinal; //남성용-어린이용소변기수
    private int ladiesToiletBowl; //여성용-대변기수
    private int ladiesHandicapToiletBowl ; //여성용-장애인용대변기수
    private int ladiesChildrenToiletBowl ; //여성용-어린이용대변기수
    private String institutionNm;//관리기관명
    private String phone;//전화번호
    private String openTime; //개방시간
    private double lat ; //x좌표위도
    private double lng;  //y좌표경도   
}
