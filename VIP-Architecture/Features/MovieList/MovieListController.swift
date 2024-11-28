//
//  MovieListController.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 03/09/24.
//

import UIKit

protocol MovieListControllerDisplayLogic: AnyObject {
    func displayNowPlaying(with items: [NowPlayingItem], currentPage: Int)
    func displayError(with error: Error)
}

class MovieListController: UIViewController {

    private let mainView: MovieListView
    
    public var interactor: IMovieListInteractor?
    
    init(view: MovieListView) {
        mainView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchNowPlaying()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
}

extension MovieListController: MovieListViewDelegate {
    func didSelectMovie(_ movie: NowPlayingItemViewModel) {
        
    }
}

extension MovieListController: MovieListControllerDisplayLogic {
    func displayNowPlaying(with items: [NowPlayingItem], currentPage: Int) {
        mainView.appendNowPlaying(movies: items)
    }
    
    func displayError(with error: Error) {
        print(error)
    }
}
