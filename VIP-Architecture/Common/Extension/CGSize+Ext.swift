//
//  CGSize+Ext.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 10/10/24.
//

import Foundation
import UIKit

extension CGSize {
    var scaledSize: CGSize {
        .init(width: width * UIScreen.main.scale, height: height * UIScreen.main.scale)
    }
}
