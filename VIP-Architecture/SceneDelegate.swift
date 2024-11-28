//
//  SceneDelegate.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 02/09/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var baseURL = URL(string: "https://api.themoviedb.org")!
    private lazy var imageBaseURL = URL(string: "https://image.tmdb.org")!
    private lazy var navigationController = UINavigationController()
    private lazy var config: APIConfig = getConfig(fromPlist: "APIConfig")
    
    lazy var httpClient: HTTPClient = {
        return makeHTTPClient().httpClient
    }()
    
    lazy var authenticatedHTTPClient: HTTPClient = {
        return makeHTTPClient(with: config).authHTTPClient
    }()
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureRootController(windowScene: windowScene)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

extension SceneDelegate {
    private func configureRootController(windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        navigationController.setViewControllers([makeMovieListController()], animated: true)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

extension SceneDelegate {
    private func makeMovieListController() -> MovieListController {
        let nowPlayingLoader = RemoteNowPlayingLoader(
            baseURL: baseURL,
            client: authenticatedHTTPClient
        )
        
        let imageDataLoader = RemoteImageDataLoader(
            baseURL: imageBaseURL,
            client: authenticatedHTTPClient
        )
        
        let view = MovieListView(
            imageDataLoader: MainQueueDispatchDecorator(imageDataLoader)
        )
        
        let controller = MovieListController(view: view)
        let presenter = MovieListPresenter(controller: controller)
        let interactor = MovieListInteractor(
            presenter: presenter,
            nowPlayingLoader: MainQueueDispatchDecorator(nowPlayingLoader)
        )
        
        controller.interactor = interactor
        view.delegate = controller
        view.handleLoadMoreNowPlaying = interactor.loadMoreNowPlaying
        
        return controller
    }
}

extension MainQueueDispatchDecorator: ImageDataLoader where T == ImageDataLoader {
    typealias Result = ImageDataLoader.Result
    
    func load(from imageURL: URL, completion: @escaping (Result) -> Void) -> any ImageDataLoaderTask {
        decoratee.load(from: imageURL) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
    
    func load(with imagePath: String, width: Int, completion: @escaping (Result) -> Void) -> any ImageDataLoaderTask {
        decoratee.load(with: imagePath, width: width) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}


extension MainQueueDispatchDecorator: NowPlayingLoader where T == NowPlayingLoader {
    public func load(_ request: PagedNowPlayingRequest,
                     completion: @escaping (NowPlayingLoader.Result) -> Void) {
        decoratee.load(request) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
