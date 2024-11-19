struct RemoteGenre: Decodable {
    let id: Int
    let name: String
    
    var toModel: Genre {
        .init(id: id, name: name)
    }
} 