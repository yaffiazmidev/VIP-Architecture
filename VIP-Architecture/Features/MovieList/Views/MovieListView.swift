//
//  MovieListView.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 03/09/24.
//

import UIKit

protocol MovieListViewDelegate: AnyObject {
    func didSelectMovie(_ movie: NowPlayingItemViewModel)
}

class MovieListView: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    let imageDataLoader: ImageDataLoader
    weak var delegate: MovieListViewDelegate?
    var handleLoadMoreNowPlaying: (() -> Void)?
    
    private var nowPlayingMovies: [NowPlayingItemViewModel] = []
    
    init(
        frame: CGRect = .zero,
        imageDataLoader: ImageDataLoader
    ) {
        self.imageDataLoader = imageDataLoader
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        configureUI()
    }
}

extension MovieListView {
    func setNowPlaying(movies: [NowPlayingItem]) {
        nowPlayingMovies = movies.asCardItem
        collectionView.reloadData()
    }
    
    func appendNowPlaying(movies: [NowPlayingItem]) {
        nowPlayingMovies.append(contentsOf: movies.asCardItem)
        collectionView.reloadData()
    }
}

extension MovieListView {
    private func configureUI() {
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset.top = 30
        collectionView.contentInset.bottom = 20
        collectionView.registerCell(NowPlayingCollectionViewCell.self)
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}

extension MovieListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, 
                        numberOfItemsInSection section: Int) -> Int {
        return nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NowPlayingCollectionViewCell = collectionView.dequeueReusableCell(at: indexPath)
        cell.fill(
            with: nowPlayingMovies[indexPath.item],
            imageDataLoader: imageDataLoader
        )
        return cell
    }
}

extension MovieListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension MovieListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, 
                        didSelectItemAt indexPath: IndexPath) {
        let movie = nowPlayingMovies[indexPath.item]
        delegate?.didSelectMovie(movie)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.isDragging else { return }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.height) {
            handleLoadMoreNowPlaying?()
        }
    }
}

extension Array where Element == NowPlayingItem {
    var asCardItem: [NowPlayingItemViewModel] {
        return map { item in
            NowPlayingItemViewModel(
                id: item.id,
                title: item.title,
                imagePath: item.imagePath,
                releaseDate: item.releaseDate,
                genre: "\(item.genreIds)"
            )
        }
    }
}
