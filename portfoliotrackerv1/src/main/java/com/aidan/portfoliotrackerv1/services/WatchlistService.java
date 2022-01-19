package com.aidan.portfoliotrackerv1.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aidan.portfoliotrackerv1.models.Watchlist;
import com.aidan.portfoliotrackerv1.repositories.WatchlistRepo;

@Service
public class WatchlistService {
	@Autowired
	private final WatchlistRepo watchlistRepo;
	
	public WatchlistService(WatchlistRepo watchlistRepo) {
		this.watchlistRepo = watchlistRepo;
	}
	//create position
	public Watchlist createWatchlist(Watchlist w) {
		return this.watchlistRepo.save(w);
	}
	//find all in watchlist
	public List<Watchlist> findAllInWatchlist() {
		return this.watchlistRepo.findAll();
	}
}

