//
//  PopularMovieCollectionViewCell.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 03/09/24.
//

import UIKit

class PopularMovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PopularMovieCollectionViewCell"
    
    // Define the label
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .lightGray // Optional: background color for the label
        return label
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        print("cell")
    }
    
    // Initialize the cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(label)
        
        // Center the label within the cell
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    // Configure the cell with text
    func configure(with text: String) {
        label.text = text
    }
}
