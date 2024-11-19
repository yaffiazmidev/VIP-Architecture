import UIKit

class MovieDetailController: UIViewController {
    private let mainView: MovieDetailView
    private let viewModel: NowPlayingItemViewModel
    private let imageDataLoader: ImageDataLoader
    private let genreLoader: GenreLoader
    private let mainQueue: DispatchQueueType = DispatchQueue.main
    
    init(
        viewModel: NowPlayingItemViewModel,
        imageDataLoader: ImageDataLoader,
        genreLoader: GenreLoader
    ) {
        self.mainView = MovieDetailView()
        self.viewModel = viewModel
        self.imageDataLoader = imageDataLoader
        self.genreLoader = genreLoader
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadImage()
        loadGenres()
        setupCloseButton()
    }
    
    private func setupCloseButton() {
        mainView.closeButton.addTarget(
            self,
            action: #selector(closeButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    private func configureView() {
        let longText = """
        Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.
        """
        
        mainView.titleLabel.text = viewModel.title + longText
        mainView.releaseDateLabel.text = formatDate(viewModel.releaseDate)
        mainView.genreLabel.text = formatGenres(viewModel.genre)
    }
    
    private func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return "Release Date: \(dateString)"
        }
        
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return "Release Date: \(dateFormatter.string(from: date))"
    }
    
    private func formatGenres(_ genres: String) -> String {
        return "Genres: \(genres)"
    }
    
    private func loadImage() {
        mainView.posterImageView.image = nil
        guard !viewModel.imagePath.isEmpty else { return }
        
        _ = imageDataLoader.load(
            with: viewModel.imagePath,
            width: Int(view.bounds.width * UIScreen.main.scale)
        ) { [weak self] result in
            self?.mainQueue.async {
                if case let .success(data) = result {
                    UIView.transition(
                        with: self?.mainView.posterImageView ?? UIImageView(),
                        duration: 0.3,
                        options: .transitionCrossDissolve
                    ) {
                        self?.mainView.posterImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    private func loadGenres() {
        genreLoader.load(.init()) { [weak self] result in
            self?.mainQueue.async {
                if case let .success(genreList) = result {
                    self?.updateGenres(with: genreList.genres)
                }
            }
        }
    }
    
    private func updateGenres(with genres: [Genre]) {
        let genreIds = viewModel.genre
            .components(separatedBy: ", ")
            .compactMap { Int($0) }
        
        let genreNames = genreIds.compactMap { id in
            genres.first { $0.id == id }?.name
        }
        
        mainView.genreLabel.text = "Genres: \(genreNames.joined(separator: ", "))"
    }
} 
