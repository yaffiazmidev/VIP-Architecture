//
//  NetworkError.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 09/10/24.
//

import Foundation

public struct NetworkErrorResponse: Codable {
    public let success: Bool?
    public let message: String?
}

public enum NetworkError: Error {
    case connectivity
    case invalidData
    case response(NetworkErrorResponse)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .connectivity: return "Tidak ada koneksi internet"
        case .invalidData: return "Gagal memuat data"
        case .response(let response): return response.message ?? "Terjadi Kesalahan"
        }
    }
}
