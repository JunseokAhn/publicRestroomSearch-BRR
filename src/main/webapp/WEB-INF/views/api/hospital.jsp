<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원api</title>
<script>


/* var xhr = new XMLHttpRequest();
var url = 'http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlMdcncListInfoInqire'; /*URL*/
var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'3Z%2BQ6%2BHzb5xtUL0lQXoKADtynzjVnPkyC8wcAu8j9S6In342YSsdx2%2FUqhPFf4xUe2XxB0ab9lptySS7xTRoRQ%3D%3D'; /*Service Key*/

queryParams += '&' + encodeURIComponent('Q0') + '=' + encodeURIComponent('서울특별시'); /*페이지번호*/
queryParams += '&' + encodeURIComponent('QZ') + '=' + encodeURIComponent('B'); /*한 페이지 결과 수*/
xhr.open('GET', url + queryParams);
xhr.onreadystatechange = function () {
    if (this.readyState == 4) {
        alert('Status: '+this.status+' Headers: '+JSON.stringify(this.getAllResponseHeaders())+' Body: '+this.responseText);
    }
};

xhr.send(''); */

</script>
<style>
aside { 
                float:right; 
                width: 20%; 
                float: right; 
                background-color: green; 
                color: white; 
                padding:5px;  
                margin:10px; 
                height:100px; 
            } 
</style>

</head>
<body>



 <div class = "gfg">GeeksforGeeks</div> 
        <article> 
            <h1>Heading . . .</h1> 
            <p>Aside tag is use to display important information 
             about the primary page.</p> 
        </article> 
        <aside> 
            <h1>Aside tag example</h1> 
            <p>Aside tag content. . .</p>  
        </aside> 
    </body> 





</body>
</html>