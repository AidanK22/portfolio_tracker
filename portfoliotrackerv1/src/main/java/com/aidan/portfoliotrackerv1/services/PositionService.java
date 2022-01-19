package com.aidan.portfoliotrackerv1.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aidan.portfoliotrackerv1.models.Position;
import com.aidan.portfoliotrackerv1.repositories.PositionRepo;

@Service
public class PositionService {
	@Autowired
	private final PositionRepo positionRepo;
	
	public PositionService(PositionRepo positionRepo) {
		this.positionRepo = positionRepo;
	}
	//create position
	public Position createPosition(Position p) {
		return this.positionRepo.save(p);
	}
	//find all positions
	public List<Position> findAllPositions() {
		return this.positionRepo.findAll();
	}
}
