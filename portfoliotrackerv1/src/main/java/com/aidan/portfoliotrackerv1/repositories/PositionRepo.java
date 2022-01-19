package com.aidan.portfoliotrackerv1.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.aidan.portfoliotrackerv1.models.Position;


public interface PositionRepo extends CrudRepository<Position, Long>  {
	List<Position> findAll();

}
