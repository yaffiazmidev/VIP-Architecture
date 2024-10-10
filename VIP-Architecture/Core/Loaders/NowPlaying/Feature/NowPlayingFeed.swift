//
//  NowPlayingFeed.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 09/10/24.
//

import Foundation

public struct NowPlayingItem: Equatable {
    public let id: Int
    public let title: String
    public let imagePath: String
    public let releaseDate: String
    public let genreIds: [Int]
    
    public init(
        id: Int,
        title: String,
        imagePath: String,
        releaseDate: String,
        genreIds: [Int]
    ) {
        self.id = id
        self.title = title
        self.imagePath = imagePath
        self.releaseDate = releaseDate
        self.genreIds = genreIds
    }
}

public struct NowPlayingFeed: Equatable {
    public let items: [NowPlayingItem]
    public let page: Int
    public let totalPages: Int
    
    public init(
        items: [NowPlayingItem],
        page: Int,
        totalPages: Int
    ) {
        self.items = items
        self.page = page
        self.totalPages = totalPages
    }
}
