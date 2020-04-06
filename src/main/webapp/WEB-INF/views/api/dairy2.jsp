<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대변 건강 진단</title>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../resources/css/hover.css">
<script src="../resources/jquery/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

var result="";
$(document).ready(function() {
	// type모양별 체크시 각 함수를 다르게 지정해서 건강진단을 함
	$('#type1').on('click', clickFunc);
	$('#type2').on('click', clickFunc);
	$('#type3').on('click', clickFunc);
	$('#type4').on('click', clickFunc);
	
	
});


function test(){

if(confirm('진단결과를 저장하시겠습니까?'))
	console.log('저장되었습니다');
	
}

//type1의 진단결과
function clickFunc(){
	result += $(this).attr("id");
	console.log(result);

	if($(this).attr("id")=="type1"||$(this).attr("id")=="type2"||$(this).attr("id")=="type3"||$(this).attr("id")=="type4")
	{
		$('#h').text('STEP2.대변의 색깔을 선택해주세요');
		 $('#type1').attr('src','../resources/img/brown.png');
	 	 $('#type2').attr('src','../resources/img/gray.png');
		 $('#type3').attr('src','../resources/img/red.png');
		 $('#type4').attr('src','../resources/img/yellow.png');
		 $("#type1").attr('id','brown'); 
		 $("#type2").attr('id','gray'); 
		 $("#type3").attr('id','red'); 
		 $("#type4").attr('id','yellow'); 
	} 
	else
	{
		//type1에 대한 건강진단
	   if(result=="type1brown"){
       window.open('type1brown','t1brown','top=200,left=200,width=330,height=250,resizable=no'); 
       result ='type1';
           	}
	
      if(result=="type1red"){
	       window.open('type1red','t1brown','top=200,left=200,width=330,height=250,resizable=no'); 
	       result ='type1';
	       
			}
	   if(result=="type1yellow"){
	       window.open('type1yellow','t1brown','top=200,left=200,width=330,height=250,resizable=no'); 
	       result ='type1';
			}
	   if(result=="type1gray"){
	       window.open('type1gray','t1brown','top=200,left=200,width=330,height=250,resizable=no'); 
	       result ='type1';
			}
        //type2에 대한 건강진단
	     if(result=="type2brown"){
	       window.open('type2brown','t2brown','top=200,left=200,width=330,height=250,resizable=no'); 
	       result ='type2';
	           	}
		
	      if(result=="type2red"){
		       window.open('type2red','t2brown','top=200,left=200,width=330,height=250,resizable=no'); 
		       result ='type2';
		       
				}
		   if(result=="type2yellow"){
		       window.open('type2yellow','t2brown','top=200,left=200,width=330,height=250,resizable=no'); 
		       result ='type2';
				}
		   if(result=="type2gray"){
		       window.open('type2gray','t2brown','top=200,left=200,width=330,height=250,resizable=no'); 
		       result ='type2';
				}
         //type3에 대한 건강진단
		   if(result=="type3brown"){
		       window.open('type3brown','t3brown','top=200,left=200,width=330,height=250,resizable=no'); 
		       result ='type3';
		           	}
			
		      if(result=="type3red"){
			       window.open('type3red','t3brown','top=200,left=200,width=330,height=250,resizable=no'); 
			       result ='type3';
			       
					}
			   if(result=="type3yellow"){
			       window.open('type3yellow','t3brown','top=200,left=200,width=330,height=250,resizable=no'); 
			       result ='type3';
					}
			   if(result=="type3gray"){
			       window.open('type3gray','t3brown','top=200,left=200,width=330,height=250,resizable=no'); 
			       result ='type3';
					}
          //type4에 대한 건강진단
			   if(result=="type4brown"){
			       window.open('type4brown','t4brown','top=200,left=200,width=330,height=250,resizable=no'); 
			       result ='type4';
			           	}
				
			      if(result=="type4red"){
				       window.open('type4red','t4brown','top=200,left=200,width=330,height=250,resizable=no'); 
				       result ='type4';
				       
						}
				   if(result=="type4yellow"){
				       window.open('type4yellow','t4brown','top=200,left=200,width=330,height=250,resizable=no'); 
				       result ='type4';
						}
				   if(result=="type4gray"){
				       window.open('type4gray','t4brown','top=200,left=200,width=330,height=250,resizable=no'); 
				       result ='type4';
						}
		}
     

} 
	 
	/*  $("#brown").on("click",function(){
		 window.open('type1brown','t1brown','top=200,left=200,width=330,height=250,resizable=no'); 
	 }); */	 	


</script>
<style>
h1{font-family: 'Do Hyeon', sans-serif; text-align:center;}
#sz{margin:0 auto;}

</style>
</head>
<body>

<h1 id='h'>STEP1.대변의 모양을 선택해주세요</h1>

<!-- 응가 모양 체크란 -->
<table id="sz">
<tr>
<td> 
<img id="type1" class="hvr-grow-shadow"  name="1" src="../resources/img/type1.png" style="width:90%"  />
</td>
<td>
<img id="type2" class="hvr-grow-shadow" name="2" src="../resources/img/type2.png" style="width:90%"/>
</td>
</tr>
<tr>
<td>
<img id="type3" class="hvr-grow-shadow" name="3" src="../resources/img/type3.png" style="width:90%"/>
</td>
<td>
<img id="type4" class="hvr-grow-shadow" name="4" src="../resources/img/type4.png" style="width:90%"/>
</td>
</tr>
</table>
 
 
 
</body>
</html>