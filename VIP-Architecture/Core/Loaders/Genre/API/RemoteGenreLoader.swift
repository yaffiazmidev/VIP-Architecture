import Foundation

public final class RemoteGenreLoader: GenreLoader {
    private struct Root: Decodable {
        let genres: [RemoteGenre]
        
        var toModel: GenreList {
            .init(genres: genres.map { $0.toModel })
        }
    }
    
    private let baseURL: URL
    private let client: HTTPClient
    private var task: HTTPClientTask?
    
    public init(baseURL: URL, client: HTTPClient) {
        self.baseURL = baseURL
        self.client = client
    }
    
    public func load(_ request: GenreRequest, completion: @escaping (GenreLoader.Result) -> Void) {
        task = client.load(enrich(request), completion: { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success((data, response)):
                completion(RemoteGenreLoader.map(data, from: response))
            }
        })
    }
    
    public func cancel() {
        task?.cancel()
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> GenreLoader.Result {
        guard response.isOK else {
            return .failure(Error.invalidData)
        }
        
        do {
            let root = try JSONDecoder().decode(Root.self, from: data)
            return .success(root.toModel)
        } catch {
            return .failure(Error.invalidData)
        }
    }
    
    private func enrich(_ request: GenreRequest) -> URLRequest {
        return .url(baseURL)
            .path("/3/genre/movie/list")
            .build()
    }
}

extension RemoteGenreLoader {
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
}

private extension HTTPURLResponse {
    var isOK: Bool {
        return statusCode == 200
    }
} 
