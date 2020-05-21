package com.example.candidatedashboard;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

public interface CandidateRepo extends CrudRepository<Candidate, Integer> {

	List<Candidate> findBySkillIdAndLocationId(int sid, int lid);

	List<Candidate> findBySkillId(int sid);

	List<Candidate> findByLocationId(int lid);
}
