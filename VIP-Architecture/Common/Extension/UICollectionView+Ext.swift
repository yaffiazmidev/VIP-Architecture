//
//  UICollectionView+Ext.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 03/09/24.
//

import UIKit

extension UICollectionView {
    func registerCell<Cell: UICollectionViewCell>(_ cell: Cell.Type) {
        let identifier = String(describing: cell)
        register(cell, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(at indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! Cell
    }
}

