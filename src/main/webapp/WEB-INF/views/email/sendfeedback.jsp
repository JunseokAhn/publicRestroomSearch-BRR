<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Write Feed Back PopUp</title>
<script src="<c:url value="/resources/js/jquery-3.4.1.js/"/>" type="text/javascript"></script>
<script type="text/javascript" >	
$(
		function()
		{
			$('#send').on
			(
					'click',
					function()
					{
						var content='';
						$.ajax
						(
							{
								url:"<c:url value="/sendFeedBack"/>",
								type:"post",
								data:{contentFromUser:content},		
								dataType:"text",
								success:
									function(flag)
									{
										if(flag=="success")
										{
											alert("피드백을 보내주셔서 감사합니다.\n더 나은 서비스를 제공하기 위해서 더욱 힘쓰겠습니다.");
											window.close();
										}										
									}
								,
								error:
									function(e)
									{
										alert(Json.Stringify(e));
									}
							}
						);	 
					}
			);
			
			$('#close').on
			(
					'click',
					function()
					{
						window.close();
					}
			);
		}
);
</script>
</head>
<body>
<textarea rows="5" cols="5"></textarea>
<input type="button" id="send" value="보내기">
<input type="button" id="close" value="취소">
</body>
</html>