//
//  MovieListPresenter.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 03/09/24.
//

import Foundation

protocol MovieListPresentingLogic {
    typealias PresenterResult<T> = Swift.Result<T, Error>
    
    func presentNowPlayingFeed(with result: PresenterResult<NowPlayingFeed>)
}

class MovieListPresenter: MovieListPresentingLogic {
    
    private weak var controller: MovieListControllerDisplayLogic?
    
    init(controller: MovieListControllerDisplayLogic) {
        self.controller = controller
    }
    
    func presentNowPlayingFeed(with result: PresenterResult<NowPlayingFeed>) {
        switch result {
            case .success(let feed):
            controller?.displayNowPlaying(with: feed.items, currentPage: feed.page)
        case .failure(let error):
            controller?.displayError(with: error)
        }
    }
}
