--sns게시판 본문 글 테이블
create table snsBoard(
    snsBoardnum         number              primary key         --글번호
    ,id                 varchar2(50)        not null            --작성자ID
    ,email              varchar2(100)       not null            --작성자email    
    ,title              varchar2(200)       not null            --제목
    ,contents           varchar2(2000)      not null            --내용
    ,inputdate          date                default sysdate     --작성일
    ,originalfile       varchar2(200)                           --첨부파일 원래이름 
    ,savedfile          varchar2(100)                           --첨부파일 저장된 이름 
);
--sns게시판 글 번호에 사용할 시퀀스
create sequence snsBoard_seq;
commit;

--댓글 테이블
create table snsReply(
	snsReplynum		    number		            primary key	        --댓글번호
	,snsBoardnum	    number 		            not null		    --본문 글번호
	,id		            varchar2(50) 	        not null		    --작성자 ID
    ,email              varchar2(100)           not null            --작성자email        
	,comments		    varchar2(500) 	        not null		    --내용
	,inputdate		    date 		            default sysdate	    --작성일
	,constraint snsReply_fk foreign key(snsBoardnum)
        references snsBoard(snsBoardnum) on delete cascade
);

--댓글 번호용 시퀀스
create sequence snsReply_seq;
commit;

insert into 
    snsBoard(
        snsBoardnum
        ,id
        ,title
        ,contents
        )values(
        snsBoard_seq.nextval
        ,'haha'
        ,'sns글제목'
        ,'sns글내용'
        );
commit;

select
	snsBoardnum
	,id
	,title
	,contents
	,to_char(inputdate, 'YYYY/MM/DD HH24:MI:SS') as inputdate
	,originalfile
	,savedfile
from
	snsBoard
where
	snsBoardnum = 3;

        