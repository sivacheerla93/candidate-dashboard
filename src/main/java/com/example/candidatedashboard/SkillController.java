package com.example.candidatedashboard;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SkillController {
	@Autowired
	SkillRepo skills;

	@GetMapping("/skills")
	public Iterable<Skill> getAllSkills() {
		return skills.findAll();
	}

	@GetMapping("/skills/{id}")
	public Optional<Skill> getSkill(@PathVariable("id") int id) {
		return skills.findById(id);
	}
}
