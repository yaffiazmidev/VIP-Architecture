//
//  MovieListInteractor.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 03/09/24.
//

import Foundation
import DENNetworking

protocol MovieListBusinessLogic {
    func fetchNowPlaying()
    func loadMoreNowPlaying()
}

protocol MovieListDataStore {
    
}

typealias IMovieListInteractor = MovieListBusinessLogic & MovieListDataStore

class MovieListInteractor: IMovieListInteractor {
    
    private var currentPage: Int = 1
    private let presenter: MovieListPresentingLogic
    private let nowPlayingLoader: NowPlayingLoader
    
    init(presenter: MovieListPresentingLogic,
         nowPlayingLoader: NowPlayingLoader
    ) {
        self.presenter = presenter
        self.nowPlayingLoader = nowPlayingLoader
    }
    
    func fetchNowPlaying() {
        nowPlayingLoader.load(.init(page: currentPage)) { [weak self] result in
            guard let self = self else { return }
            
            self.presenter.presentNowPlayingFeed(with: result)
        }
    }
    
    func loadMoreNowPlaying() {
        currentPage += 1
        fetchNowPlaying()
    }
}
