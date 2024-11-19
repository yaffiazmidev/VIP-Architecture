private func configurePosterImage() {
    contentView.addSubview(posterImageView)
    posterImageView.translatesAutoresizingMaskIntoConstraints = false
    
    let imageHeight: CGFloat = 300 // Fixed max height of 300
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