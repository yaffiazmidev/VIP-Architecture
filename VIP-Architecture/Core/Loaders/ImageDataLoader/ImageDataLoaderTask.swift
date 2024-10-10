//
//  ImageDataLoaderTask.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 10/10/24.
//


import Foundation

protocol ImageDataLoaderTask {
    func cancel()
}

protocol ImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    
    func load(
        from imageURL: URL,
        completion: @escaping (Result) -> Void
    ) -> ImageDataLoaderTask
    
    func load(
        with imagePath: String,
        width: Int,
        completion: @escaping (Result) -> Void
    ) -> ImageDataLoaderTask
}
