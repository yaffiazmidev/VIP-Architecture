//
//  APIConfig.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 09/10/24.
//

import Foundation

public struct APIConfig: Decodable {
    public let secret: String
    
    public init(secret: String) {
        self.secret = secret
    }
}
