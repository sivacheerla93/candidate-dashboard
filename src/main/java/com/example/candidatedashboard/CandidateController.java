package com.example.candidatedashboard;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
public class CandidateController {
	@Autowired
	CandidateRepo candidates;

	@GetMapping("/candidates")
	public Iterable<Candidate> getAllCandidates() {
		return candidates.findAll();
	}

	@GetMapping("/candidates/{id}")
	public Candidate getCandidate(@PathVariable("id") int id) {
		Optional<Candidate> candidate = candidates.findById(id);
		if (candidate.isPresent())
			return candidate.get();
		else
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Candidate Id Not Found");
	}
}
