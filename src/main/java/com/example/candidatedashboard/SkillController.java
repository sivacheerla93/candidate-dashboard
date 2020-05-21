package com.example.candidatedashboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SkillController {
	@Autowired
	SkillRepo skills;

	@GetMapping("/skills")
	public Iterable<Skill> getAllSkills() {
		return skills.findAll();
	}
}
