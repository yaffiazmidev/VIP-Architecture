public struct GenreRequest {
    public init() {}
}

public protocol GenreLoader {
    typealias Result = Swift.Result<GenreList, Error>
    func load(_ request: GenreRequest, completion: @escaping (Result) -> Void)
}

public struct Genre: Equatable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

public struct GenreList: Equatable {
    public let genres: [Genre]
    
    public init(genres: [Genre]) {
        self.genres = genres
    }
} 