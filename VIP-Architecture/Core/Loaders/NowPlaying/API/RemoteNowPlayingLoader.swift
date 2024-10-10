//
//  RemoteNowPlayingLoader.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 09/10/24.
//

import Foundation

public final class RemoteNowPlayingLoader: NowPlayingLoader {
    
    public typealias Result = NowPlayingLoader.Result
    
    private let baseURL: URL
    private let client: HTTPClient
    private var task: HTTPClientTask?
    
    public init(baseURL: URL, client: HTTPClient) {
        self.baseURL = baseURL
        self.client = client
    }
    
    public func load(_ request: PagedNowPlayingRequest, completion: @escaping (Result) -> Void) {
        task = client.load(enrich(request), completion: { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success((data, response)):
                completion(RemoteNowPlayingLoader.map(data, from: response))
            }
        })
    }
    
    public func cancel() {
        task?.cancel()
    }
}

extension RemoteNowPlayingLoader {
    static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let result = try Mapper<RemoteNowPlayingFeed>.map(data, from: response)
            return .success(result.asPageDTO)
        } catch {
            return .failure(NetworkError.invalidData)
        }
    }
}

private extension RemoteNowPlayingLoader {
    private func enrich(_ request: PagedNowPlayingRequest) -> URLRequest {
        return .url(baseURL)
            .path("/3/movie/now_playing")
            .queries([
                .init(name: "language", value: request.language),
                .init(name: "query", value: request.query),
                .init(name: "page", value: "\(request.page)")
            ])
            .build()
    }
}

extension RemoteNowPlayingFeed {
    var asPageDTO: NowPlayingFeed {
        return NowPlayingFeed(
            items: results.asCardDTO,
            page: page,
            totalPages: total_pages
        )
    }
}

extension Array where Element == RemoteNowPlayingItem {
    var asCardDTO: [NowPlayingItem] {
        return map { item in
            NowPlayingItem(
                id: item.id,
                title: item.original_title,
                imagePath: item.poster_path ?? "",
                releaseDate: item.release_date ?? "",
                genreIds: item.genre_ids ?? []
            )
        }
    }
}
