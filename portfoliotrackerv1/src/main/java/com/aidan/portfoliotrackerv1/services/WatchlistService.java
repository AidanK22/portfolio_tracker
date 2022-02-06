package com.aidan.portfoliotrackerv1.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aidan.portfoliotrackerv1.models.Position;
import com.aidan.portfoliotrackerv1.models.User;
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
	//find all in user watchlist
	public List<Watchlist> findWatchlistByWatcher(User watcher) {
		return this.watchlistRepo.findAllByWatcher(watcher);
	}
	//find all watching item
//	public List<Watchlist> findWatcherInWatchlist(int apiId) {
//		return this.watchlistRepo.findUserIdsInWatchlistByApidId(apiId);
//	}
	
//	//find all by user id
//	public List<Watchlist> findWatchlistByUserId(Long id){
//		return this.watchlistRepo.findAllByUserId(id);
//	}
	
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
	
	//
	
	public List<Watchlist> findUsersInWatchlistByWatcherId(Long watcher) {
		System.out.println("watcher from service");
		System.out.println(watcher);
        return this.watchlistRepo.findByWatcherId(watcher);
	}
}

