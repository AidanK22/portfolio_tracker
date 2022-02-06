package com.aidan.portfoliotrackerv1.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.aidan.portfoliotrackerv1.models.Position;
import com.aidan.portfoliotrackerv1.models.User;
import com.aidan.portfoliotrackerv1.models.Watchlist;

@Repository
public interface WatchlistRepo extends CrudRepository<Watchlist, Long> {
	List<Watchlist> findAll();
	List<Watchlist> findAllByWatcher(User watcher);
	
//	List<Watchlist> findAllByUsersId(Long id);
//	
//	List<User> findUserIdsInWatchlistByApidId(int apiId);
	
	Watchlist findByApiId(int apiId);
	
	Watchlist deleteByApiId(int apiId);
	
	@Query("select w from Watchlist w where users_id = ?1")
	List<Watchlist> findByWatcherId(Long usersId);
}
