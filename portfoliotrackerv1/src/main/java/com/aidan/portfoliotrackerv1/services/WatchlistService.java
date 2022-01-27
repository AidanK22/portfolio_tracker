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
	//create watchist
	public Watchlist createWatchlist(Watchlist w) {
		return this.watchlistRepo.save(w);
	}
	//find all in watchlist
	public List<Watchlist> findAllInWatchlist() {
		return this.watchlistRepo.findAll();
	}
	//find by id
	public Watchlist findWatchlistById(Long id) {
		return this.watchlistRepo.findById(id).orElse(null);
	}
	public List<Watchlist> findWatchlistByWatcher(Long id) {
		return this.watchlistRepo.findAllByWatcher(id);
	}
	//update
	//delete
	public void deleteWatchlist(Long id) {
		watchlistRepo.deleteById(id);
	}
	//delete watchlist by id
	public void deleteWatchlistByApiId(int apiId) {
		watchlistRepo.deleteByApiId(apiId);
	}
	//find watchlist by apiId
	public Watchlist findWatchlistByApiId(int apiId) {
		return this.watchlistRepo.findByApiId(apiId);
	}
}

