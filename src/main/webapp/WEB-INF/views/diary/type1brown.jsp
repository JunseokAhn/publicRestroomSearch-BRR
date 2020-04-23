<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" integrity="sha256-R4pqcOYV8lt7snxMQO/HSbVCFRPMdrhAFMH+vr9giYI=" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">
<script src="../resources/jquery/jquery-3.4.1.min.js"></script>
<style>
#chartsize{width:40%; height:40%;}
p{font-family: 'Gamja Flower', cursive; margin-left:-2em;}
</style>

<script type="text/javascript">



function save(){

	console.log('저장완료');
	alert('저장되엇습니다');
	
	
	
}



</script>
</head>
<body>


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
            data: [3,1 ,2 ],
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
<td id='1'  style="display:none">1</td> 
<td>
<img id="type1brown" src="../resources/img/normal.png"  style="width:50%"  />
</td>
<td>
<p>영양소는 적당하지만,<Strong>변비</Strong> 증세가 있네요.
 <br>수분섭취와 스트레스를 줄여보세요.</p> 
</td>
</tr>
</table>

<input type="hidden" name="status" value="1">
<input type="hidden" name="resnum" value="1">
<input id="bt" style=" margin-top:-33px; width:50pt; height:25pt; font-size:10px;" type="submit" value="저장">
</form>
</body>
</html>