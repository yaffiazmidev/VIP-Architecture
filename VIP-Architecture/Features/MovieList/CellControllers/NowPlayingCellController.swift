//
//  NowPlayingCellController.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 10/10/24.
//

import UIKit

protocol NowPlayingCellControllerDelegate {
    func didRequestCancelLoadImage()
    func didRequestLoadImage()
}

final class NowPlayingCellController: Hashable {
	
	private let model: NowPlayingItemViewModel
	private let delegate: NowPlayingCellControllerDelegate
	
	var didSelect: (() -> Void)?
	
	init(model: NowPlayingItemViewModel, delegate: NowPlayingCellControllerDelegate) {
		self.model = model
		self.delegate = delegate
	}
	
	static func == (lhs: NowPlayingCellController, rhs: NowPlayingCellController) -> Bool {
		return lhs.model.id == rhs.model.id
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(model.id)
	}
	
    private var cell: NowPlayingCollectionViewCell?
	
	func view(in collectionView: UICollectionView, forItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cell = collectionView.dequeueReusableCell(at: indexPath)
		cell?.titleLabel.text = model.title
		
		return cell!
	}
	
	func cancelLoad() {
		delegate.didRequestCancelLoadImage()
		releaseCellForReuse()
	}
	
	func prefetch() {
		delegate.didRequestLoadImage()
	}
	
	func select() {
		didSelect?()
	}
}

private extension NowPlayingCellController {
	func releaseCellForReuse() {
		cell = nil
	}
}
