//
//  MovieListController.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 03/09/24.
//

import UIKit

class MovieListController: UIViewController {

    private(set) lazy var mainView: MovieListView = {
        let view = MovieListView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = mainView
    }
}
