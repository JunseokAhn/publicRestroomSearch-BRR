<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" integrity="sha256-R4pqcOYV8lt7snxMQO/HSbVCFRPMdrhAFMH+vr9giYI=" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">
<style>
#chartsize{width:40%; height:40%;}
p{font-family: 'Gamja Flower', cursive; margin-left:-1em;}
</style>
<script>
function save(){
	var result = document.getElementById("1").innerHTML;

	 window.opener.test(result);
		
		
		
	}
</script>
</head>
<body onunload="javascript:save();">


<div class="chart-container" style="position: relative; height:10vh; width:50vw; margin:auto; ">
<canvas id="myChart" width="10" height="10"></canvas>

<script>
var ctx = document.getElementById('myChart').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: ['스트레스', '수분', '세균'],
        datasets: [{
            label: '',
            data: [5,1,3 ],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(0, 255, 0, 0.2)',
                
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(0, 255, 0, 1)',
               
            ],
            borderWidth: 1
            
           
        }]
    },
    options: {
    	 legend:{
             display:false
      },  
        scales: { 
            yAxes: [{
                ticks: {
                    beginAtZero: true,
                    display : false
                    
                },
                gridLines:{
                     lineWidth:0
                     
                    }
            }]
        }
    }
});
</script>
</div>
<form action="insert" method="post">
<table style="margin-top:50%">
<tr>
<td id='1' style="display:none">2</td> 
<td id='resvalue' style="display:none">2</td> 
<td>
<img id="type1brown" src="../resources/img/dangerous.png"  style="width:65%"  />
</td>
<td>
 <p> 장건강의 이상으로 색깔이 변이될 수 있어요.
<strong>악취</strong>가 나는 경우에는 진단을 받아 볼 필요가 있습니다.</p> 
</td>
</tr>
</table>
<input type="hidden" name="status" value="2">
<input type="hidden" name="resnum" value="2">
<input id="bt" style=" margin-top:-33px; width:50pt; height:25pt; font-size:10px;" type="submit" value="저장">
</form>
</body>
</html>