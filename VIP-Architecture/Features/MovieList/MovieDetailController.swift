private func loadImage() {
    mainView.posterImageView.image = nil
    guard !viewModel.imagePath.isEmpty else { return }
    
    _ = imageDataLoader.load(
        with: viewModel.imagePath,
        width: Int(view.bounds.width * 3 * UIScreen.main.scale) // Increased width multiplier for higher quality
    ) { [weak self] result in
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