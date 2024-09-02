//
//  MovieListController.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 03/09/24.
//

import UIKit

protocol MovieListControllerDisplayLogic: AnyObject {
    func display()
}

class MovieListController: UIViewController {

    private(set) lazy var mainView: MovieListView = {
        let view = MovieListView()
        return view
    }()
    
    private let interactor: IMovieListInteractor
    
    init(interactor: IMovieListInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
}

extension MovieListController: MovieListControllerDisplayLogic {
    func display() {
        
    }
}
