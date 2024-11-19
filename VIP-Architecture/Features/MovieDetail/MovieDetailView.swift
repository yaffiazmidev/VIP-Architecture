import UIKit

class MovieDetailView: UIView {
    private(set) lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private(set) lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private(set) lazy var posterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.1
        return view
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private(set) lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        return label
    }()
    
    private(set) lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        return label
    }()
    
    private(set) lazy var infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .leading
        stack.backgroundColor = .white
        return stack
    }()
    
    private(set) lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private var initialImageHeight: CGFloat = 0
    private var imageHeightConstraint: NSLayoutConstraint?
    private var imageTopConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        scrollView.delegate = self
        configureUI()
    }
}

extension MovieDetailView {
    private func configureUI() {
        configureScrollView()
        configurePosterImage()
        configureInfoStack()
        configureCloseButton()
    }
    
    private func configureScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func configurePosterImage() {
        contentView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageHeight = UIScreen.main.bounds.width * 0.5
        initialImageHeight = imageHeight
        
        imageHeightConstraint = posterImageView.heightAnchor.constraint(equalToConstant: imageHeight)
        imageTopConstraint = posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageTopConstraint!,
            imageHeightConstraint!
        ])
    }
    
    private func configureCloseButton() {
        addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            closeButton.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        bringSubviewToFront(closeButton)
    }
    
    private func configureInfoStack() {
        contentView.addSubview(infoStackView)
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(releaseDateLabel)
        infoStackView.addArrangedSubview(genreLabel)
        
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 24),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}

extension MovieDetailView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        // Handle stretchy header
        if offsetY < 0 {
            imageHeightConstraint?.constant = initialImageHeight - offsetY
            imageTopConstraint?.constant = offsetY
            
            // Adjust zoom effect
            let scale = 1 + (-offsetY / initialImageHeight)
            posterImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        } else {
            imageHeightConstraint?.constant = initialImageHeight
            imageTopConstraint?.constant = 0
            posterImageView.transform = .identity
        }
        
        // Adjust close button alpha based on scroll
        let closeButtonAlpha = min(1.0, 1.0 - (offsetY / 50.0))
        closeButton.alpha = closeButtonAlpha
    }
} 
