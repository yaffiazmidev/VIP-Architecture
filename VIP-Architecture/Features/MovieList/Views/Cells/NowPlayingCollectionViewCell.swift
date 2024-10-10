//
//  NowPlayingCollectionViewCell.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 10/10/24.
//

import UIKit

class NowPlayingCollectionViewCell: UICollectionViewCell {
    
    // Define the cover image
    private(set) lazy var coverImageView: UIImageView = UIImageView()
    private(set) lazy var titleLabel: UILabel = UILabel()
    
    private var viewModel: NowPlayingItemViewModel?
    private var imageDataLoader: ImageDataLoader?
    private var imageDataTask: ImageDataLoaderTask? { willSet { imageDataTask?.cancel() } }
    private let mainQueue: DispatchQueueType = DispatchQueue.main
    
    // Initialize the cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.isShimmering = true
        coverImageView.image = nil
        titleLabel.text = nil
        
        viewModel = nil
        imageDataTask = nil
        imageDataLoader = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with viewModel: NowPlayingItemViewModel,
              imageDataLoader: ImageDataLoader?
    ) {
        self.viewModel = viewModel
        self.imageDataLoader = imageDataLoader
        
        titleLabel.text = viewModel.title
        updateCoverImage(width: Int(coverImageView.imageSizeAfterAspectFit.scaledSize.width))
    }
    
    func updateCoverImage(width: Int) {
        coverImageView.image = nil
        contentView.isShimmering = true
        guard let coverImagePath = viewModel?.imagePath else { return }
        
        imageDataTask = imageDataLoader?.load(
            with: coverImagePath,
            width: width
        ) { [weak self] result in
            self?.mainQueue.async {
                guard self?.viewModel?.imagePath == coverImagePath else { return }
                if case let .success(data) = result {
                    self?.coverImageView.image = UIImage(data: data)
                    self?.contentView.isShimmering = false
                }
                self?.imageDataTask = nil
            }
        }
    }
}

extension NowPlayingCollectionViewCell {
    func configureUI() {
        configureCoverImage()
        configureTitleLabel()
    }
    
    func configureCoverImage() {
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        coverImageView.backgroundColor = .lightGray
        coverImageView.layer.cornerRadius = 8
        
        contentView.addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            coverImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func configureTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .left
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: coverImageView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
