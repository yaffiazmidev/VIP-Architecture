//
//  MovieListInteractor.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 03/09/24.
//

import Foundation
import DENNetworking

protocol MovieListBusinessLogic {
    func fetchList()
}

protocol MovieListDataStore {
    var currentPage: Int { get set }
}

typealias IMovieListInteractor = MovieListBusinessLogic & MovieListDataStore

class MovieListInteractor: IMovieListInteractor {
    
    private let presenter: MovieListPresentingLogic
    var currentPage: Int = 1
    
    init(presenter: MovieListPresentingLogic) {
        self.presenter = presenter
    }
    
    func fetchList() {
        print("azmi")
    }
}
