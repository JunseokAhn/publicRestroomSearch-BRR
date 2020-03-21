package global.sesoc.brr.controller;

import java.net.URI;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@Controller
@RequestMapping(value = "maps")
public class GoogleMapsController {

	@GetMapping(value = "mapsMain")
	public String MapsMain(Model model) {
		RestTemplate restTemplate = new RestTemplate();
		URI uri = UriComponentsBuilder.fromHttpUrl(//길찾기경로 origin=출발지 destination=도착지인것같다.
				"https://maps.googleapis.com/maps/api/directions/json?origin=41.43206,-81.38992&destination=41.43206,-81.38992&key=AIzaSyDkQ00U2AUBQSS1CJF5YveL-1YWsTjaRGA")
				.queryParam("key", "value").build().toUri();
		// String response = restTemplate.getForObject(uri, String.class); 또는
		ResponseEntity<String> responseEntity = restTemplate.getForEntity(uri, String.class);
		System.out.println(responseEntity);
		model.addAttribute("directions", responseEntity);
		return "maps/mapsMain";
	}

}
