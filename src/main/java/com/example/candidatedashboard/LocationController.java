package com.example.candidatedashboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LocationController {
	@Autowired
	LocationRepo locations;

	@GetMapping("/locations")
	public Iterable<Location> getAllLocations() {
		return locations.findAll();
	}
}
