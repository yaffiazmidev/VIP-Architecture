//
//  NowPlayingItemViewModel.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 10/10/24.
//


public struct NowPlayingItemViewModel: Equatable {
	public let id: Int
	public let title: String
	public let imagePath: String
	public let releaseDate: String
	public let genre: String
	
	public init(
		id: Int,
		title: String,
		imagePath: String,
		releaseDate: String,
		genre: String
	) {
		self.id = id
		self.title = title
		self.imagePath = imagePath
		self.releaseDate = releaseDate
		self.genre = genre
	}
}