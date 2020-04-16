<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../resources/jquery/jquery-3.4.1.min.js"></script>
 <link href='../resources/packages/core/main.css' rel='stylesheet' />
 <link href='../resources/packages/daygrid/main.css' rel='stylesheet' />

  <script src='../resources/packages/core/main.js'></script>
  <script src='../resources/packages/daygrid/main.js'></script>
  <script>
  document.addEventListener('DOMContentLoaded', function() {
      var calendarEl = document.getElementById('calendar');

      var calendar = new FullCalendar.Calendar(calendarEl, {
        plugins: [ 'dayGrid', 'list']
      });

      calendar.render();


      calendar.batchRendering(function() {
          
    	 
    	});
    	
      
    });

  
  
  </script>
</head>
<body>
<div id='calendar'></div>

</body>
</html>