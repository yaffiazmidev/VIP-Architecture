//
//  RemoteNowPlayingFeed.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 09/10/24.
//

import Foundation

public struct RemoteNowPlayingFeed: Codable {
    let results: [RemoteNowPlayingItem]
    let page: Int
    let total_pages: Int
}

public struct RemoteNowPlayingItem: Codable {
    let id: Int
    let original_title: String
    var poster_path: String?
    let genre_ids: [Int]?
    let release_date: String?
}
