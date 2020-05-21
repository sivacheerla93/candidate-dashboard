package com.example.candidatedashboard;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LocationController {
	@Autowired
	LocationRepo locations;

	@GetMapping("/locations")
	public Iterable<Location> getAllLocations() {
		return locations.findAll();
	}

	@GetMapping("/locations/{id}")
	public Optional<Location> getSkill(@PathVariable("id") int id) {
		return locations.findById(id);
	}
}
