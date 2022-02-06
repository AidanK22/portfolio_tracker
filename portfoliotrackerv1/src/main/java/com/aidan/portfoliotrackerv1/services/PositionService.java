package com.aidan.portfoliotrackerv1.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aidan.portfoliotrackerv1.models.Position;
import com.aidan.portfoliotrackerv1.models.User;
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
	//find by id
	public Position findPositionById(Long id) {
		return this.positionRepo.findById(id).orElse(null);
	}
	
	//find position by user id
	public List<Position> findPositionsByOwner(User owner){
		return this.positionRepo.findAllByOwner(owner);
	}
	
	//update position
	public Position updatePosition(Position p, int apiId) {
		p.setApiId(apiId);
		return this.positionRepo.save(p);
	}
	//delete position by id
		public void deletePositionById(Long id) {
			positionRepo.deleteById(id);
		}
}
