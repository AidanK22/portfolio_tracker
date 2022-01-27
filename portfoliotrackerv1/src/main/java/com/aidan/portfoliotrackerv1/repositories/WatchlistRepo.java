package com.aidan.portfoliotrackerv1.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.aidan.portfoliotrackerv1.models.Watchlist;

@Repository
public interface WatchlistRepo extends CrudRepository<Watchlist, Long> {
	List<Watchlist> findAll();
	List<Watchlist> findAllByWatcher(Long id);
	Watchlist findByApiId(int apiId);
	
	Watchlist deleteByApiId(int apiId);
}
