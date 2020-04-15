<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>brr 상세글</title>
<script src="../resources/js/jquery-3.4.1.js"></script>
<%--BootStrap Getting Started--%>
<link rel="stylesheet" type="text/css" href="../resources/css/materialize.css">
<link rel="stylesheet" type="text/css" href="../resources/css/materialize.min.css">

<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../resources/css/boardStyle.css">
<link rel="stylesheet" type="text/css" href="../resources/css/snsBoardStyle.css">

<script>

//snsBoard
var count = 0;
//스크롤 바닥 감지
window.onscroll = function(e) {
    //추가되는 임시 콘텐츠
    //window height + window scrollY 값이 document height보다 클 경우,
    if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
    	//실행할 로직 (콘텐츠 추가)
        count++;
        var addContent = '<div class="mx-auto block form-group"><p>'+ count +'번째로 추가된 콘텐츠</p></div>';
			addContent += '<div class="mx-auto boardButton form-group"><button type="button" class="btn btn-secondary btn-sm">댓글</button>';
			addContent += '</div>';
        //article에 추가되는 콘텐츠를 append
        $('article').append(addContent);
    }
};

//메모글부분
function boardDelete() {
	if(confirm("삭제하시겠습니까?")) {
		location.href='deleteBoard?boardnum=${board.boardnum}';
	}	
}
function boardUpdate() {
	if(confirm("수정하시겠습니까?")) {
		location.href='updateBoard?boardnum=${board.boardnum}';
	}	
}
function boardList() {
	if(confirm("목록으로 돌아가겠습니까?")) {
		location.href='listBoard';
	}	
}

</script>


</head>
<body>
	
<!-- 무한스크롤 -->
<header>
	<h1 class="pageTitle"><span>b</span><span>rr</span>
		<!-- sns글쓰기 -->
		<div class="mx-auto boardButton form-group">
			<button type="button" class="btn btn-success"
				onclick="location.href='snsWrite';">sns글쓰기</button>
			<button type="button" class="btn btn-success"
				onclick="location.href='snsWrite';">리뷰게시판</button>
		</div>
	</h1>	
</header>

<c:if test="${listSNS == null}">
		<p>게시물이 존재하지 않습니다.</p>
</c:if>

<c:if test="${listSNS != null}">
</c:if>
<!-- 제일처음에 넣을 부분 -->
<div class="mx-auto form-group">
</div>
<article>
	<c:forEach var="sns" items="${listSNS}">	
	<!-- 반복시작 -->
		<div class="mx-auto block form-group">
		<!-- 글쓰기 -->
			<div class="row">
				<div class="id col-md-auto"><span>ID: ${sns.id}</span></div>
				<div class="date col"><span>등록일: ${sns.inputdate}</span></div>
			</div>
			<div class="row">
				<div class="col-md-auto"><span>내용넣기: ${sns.contents}</span></div>
			</div>
		</div>
		<div class="mx-auto boardButton form-group">
			<button type="button" class="btn btn-secondary btn-sm" 
			onclick="location.href='readSNS?snsBoardnum=${sns.snsBoardnum}';">댓글</button>
		</div>
	</c:forEach>
	<!-- 반복종료 -->
<!-- 반복 -->	

<!-- 댓글폼 -->
  <div class="row">
    <div class="col s12">
      <div class="row">
        <div class="input-field col s12">
          <i class="material-icons prefix">textsms</i>
          <input type="text" id="autocomplete-input" class="autocomplete">
          <label for="autocomplete-input">Autocomplete</label>
        </div>
      </div>
    </div>
  </div>	
</article>
	
</body>

</html>