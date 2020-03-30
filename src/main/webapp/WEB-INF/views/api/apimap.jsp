<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <title>Simple Map</title>
    <meta name="viewport" content="initial-scale=1.0">
    <meta charset="utf-8">
    



    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
    
    
    
    
  </head>
  <body>
    <div id="map"></div>
    <script>
      var map;
      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: 37.508861, lng: 127.063149},
          zoom: 18
        });

        var script = document.createElement('script');
        script.src = 'https://developers.google.com/maps/documentation/javascript/examples/json/earthquake_GeoJSONP.js';
        document.getElementsByTagName('head')[0].appendChild(script);
      }
      // 리스트 정보를 for문을 돌려 각각의 위치에 마커를 표시한다.
      // set of coordinates.
      window.eqfeed_callback = function(results) {
          for (var i = 0; i < results.features.length; i++) {
              var coords = results.features[i].geometry.coordinates;
              var latLng = new google.maps.LatLng(coords[1],coords[0]); //위도 경도 변수
              var marker = new google.maps.Marker({
                  position: latLng, //여기에 위도 경도 정보를 입력하고 마커 생성
                  map: map
              });
          }
      }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB4zsnpHodiY_By9Q6EOROvG4omJQVlf_o&callback=initMap"
    async defer></script>
    
 
    
  </body>
</html>