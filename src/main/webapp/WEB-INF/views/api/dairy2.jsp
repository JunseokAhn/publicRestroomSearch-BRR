<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/hover.css">
<script src="../resources/jquery/jquery-3.4.1.min.js"></script>
<script>
$(document).ready(function() {
	
	$('#type1').on('click', check);
	$('#type2').on('click', check);
	$('#type3').on('click', check);
	$('#type4').on('click', check);
	
});

function check() {
	
	
	$.ajax({
		url : 'dairy2',
		type : 'get',
        success : function() {
			
			change();
			
		},
		error : function(e) {
			alert(JSON.stringify(e));
		}
	});
}

function change(){
	 $('#h').text('똥 색깔 체크');
	 $('#type1').attr('src','../resources/img/brown.png');
 	 $('#type2').attr('src','../resources/img/gray.png');
	 $('#type3').attr('src','../resources/img/red.png');
	 $('#type4').attr('src','../resources/img/yellow.png');
	 $("#type1").attr('id','brown'); 
	 $("#type2").attr('id','gray'); 
	 $("#type3").attr('id','red'); 
	 $("#type4").attr('id','yellow'); 
}

</script>
</head>
<body>
<h1 id='h'>똥 모양 체크</h1>

<!-- 응가 모양 체크란 -->
<table>
<tr>
<td> 
<div class="hvr-grow-shadow">
<img id="type1" src="../resources/img/type1.png"  />
</div>
</td>

<td>
<div class="hvr-grow-shadow">
<img id="type2" class="hvr-border-fade" src="../resources/img/type2.png"/>
</div>
</td>
</tr>

<tr>
<td>
<div class="hvr-grow-shadow">
<img id="type3" class="hvr-border-fade" src="../resources/img/type3.png"/>
</div>
</td>
<td>
<div class="hvr-grow-shadow">
<img id="type4" class="hvr-border-fade" src="../resources/img/type4.png" />
</div>
</td>
</tr>
</table>
 
 
 
</body>
</html>