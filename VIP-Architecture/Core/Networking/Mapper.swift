//
//  Mapper.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 09/10/24.
//

import Foundation

public final class Mapper<T: Codable> {
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> T {
        guard (200...299).contains(response.statusCode) else { if let error = try? JSONDecoder().decode(NetworkErrorResponse.self, from: data) {
            throw NetworkError.response(error)
        }
            throw NetworkError.connectivity
        }
        
        guard let response = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.invalidData
        }
        
        return response
    }
}
