//
//  RemoteImageDataLoader.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 10/10/24.
//

import Foundation

final class RemoteImageDataLoader: ImageDataLoader {
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidResponse
    }
    
    typealias Result = ImageDataLoader.Result
    
    private let baseURL: URL
    private let client: HTTPClient
    
    init(baseURL: URL, client: HTTPClient) {
        self.baseURL = baseURL
        self.client = client
    }
    
    func load(from imageURL: URL, completion: @escaping (Result) -> Void) -> ImageDataLoaderTask {
        let task = HTTPClientTaskWrapper(completion)
        
        task.wrapped = client.load(URLRequest(url: imageURL), completion: { [weak self] result in
            guard self != nil else { return }
            task.complete(with: result
                .mapError { _ in Error.connectivity }
                .flatMap { (data, response) in
                    let isValidResponse = response.statusCode == 200 && !data.isEmpty
                    return isValidResponse ? .success(data) : .failure(Error.invalidResponse)
                })
        })
        
        return task
    }
    
    func load(with imagePath: String, width: Int, completion: @escaping (Result) -> Void) -> any ImageDataLoaderTask {
        
        let sizes = [92, 154, 185, 342, 500, 780]
        let closestWidth = sizes
            .enumerated()
            .min { abs($0.1 - width) < abs($1.1 - width) }?
            .element ?? sizes.first!
        
        let request = makeImageURL(withPath: "t/p/w\(closestWidth)\(imagePath)")
        return load(from: request, completion: completion)
    }
}

private extension RemoteImageDataLoader {
    func makeImageURL(withPath path: String) -> URL {
        return baseURL.appendingPathComponent(path)
    }
}

private final class HTTPClientTaskWrapper: ImageDataLoaderTask {
    
    private var completion: ((ImageDataLoader.Result) -> Void)?
    
    var wrapped: HTTPClientTask?
    
    init(_ completion: @escaping (ImageDataLoader.Result) -> Void) {
        self.completion = completion
    }
    
    func complete(with result: ImageDataLoader.Result) {
        completion?(result)
    }
    
    func cancel() {
        preventFurtherCompletions()
        wrapped?.cancel()
    }
    
    private func preventFurtherCompletions() {
        completion = nil
    }
}
