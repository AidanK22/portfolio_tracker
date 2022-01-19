package com.aidan.portfoliotrackerv1.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.aidan.portfoliotrackerv1.models.Watchlist;

public interface WatchlistRepo extends CrudRepository<Watchlist, Long> {
	List<Watchlist> findAll();
}
