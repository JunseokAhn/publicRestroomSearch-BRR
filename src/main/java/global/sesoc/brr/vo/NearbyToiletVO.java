package global.sesoc.brr.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NearbyToiletVO 
{	
	private String toiletNm; // 화장실 이름
    private String toiletType;  // 화장실 타입  개방 or 공중
    private String lnmadr; // 화장실 주소
    private String unisexToiletYn; //남녀공용화장실 여부
    private int menToiletBowlNumber; //남성용 대변기 수
    private int menUrineNumber; // 남성용-소변기수
    private int menHandicapToiletBowlNumber; //남성용-장애인용대변기수
    private int menHandicapUrinalNumber; //남성용-장애인용소변기수
    private int menChildrenToiletBowlNumber; //남성용-어린이용대변기수
    private int menChildrenUrinalNumber; //남성용-어린이용소변기수
    private int ladiesToiletBowlNumber; //여성용-대변기수
    private int  ladiesHandicapToiletBowlNumber ; //여성용-장애인용대변기수
    private int ladiesChildrenToiletBowlNumber ; //여성용-어린이용대변기수
    private String institutionNm;//관리기관명
    private String phoneNumber;//전화번호
    private String openTime; //개방시간
    private double lat ; //x좌표위도
    private double lng;  //y좌표경도   
    private int distance; //현재 위치와의 거리
}
