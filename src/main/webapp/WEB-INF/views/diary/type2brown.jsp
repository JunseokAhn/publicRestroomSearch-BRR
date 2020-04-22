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
        labels: ['스트레스', '수분', '영양소'],
        datasets: [{
            label: '',
            data: [0,5,5 ],
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
<td id='1' style="display:none">3</td> 
<td id='resvalue' style="display:none">5</td> 
<td>
<img id="type2brown" src="../resources/img/good.png"  style="width:60%"  />
</td>
<td>
 <p> 색깔도 모양도 완벽해요. 당신의 대변 건강은 <strong>최고</strong>입니다.</p>
</td>
</tr>
</table>
<input type="hidden" name="status" value="3">
<input type="hidden" name="resnum" value="5">
<input id="bt" style=" margin-top:-33px; width:50pt; height:25pt; font-size:10px;" type="submit" value="저장">
</form>
</body>
</html>