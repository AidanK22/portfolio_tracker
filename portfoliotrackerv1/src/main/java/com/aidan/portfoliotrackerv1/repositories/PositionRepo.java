package com.aidan.portfoliotrackerv1.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.aidan.portfoliotrackerv1.models.Position;
import com.aidan.portfoliotrackerv1.models.User;
import com.aidan.portfoliotrackerv1.models.Watchlist;


public interface PositionRepo extends CrudRepository<Position, Long>  {
	List<Position> findAll();
	List<Position> findAllByOwner(User owner);
}
