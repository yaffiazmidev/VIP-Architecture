//
//  AuthenticatedHTTPClientDecorator.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 09/10/24.
//

import Foundation

public class AuthenticatedHTTPClientDecorator: HTTPClient {

    public typealias Result = HTTPClient.Result

    private let decoratee: HTTPClient
    private let config: APIConfig

    public init(decoratee: HTTPClient, config: APIConfig) {
        self.decoratee = decoratee
        self.config = config
    }

    public func load(_ request: URLRequest, completion: @escaping (Result) -> Void) -> HTTPClientTask {
        let request = enrich(request, with: config)
        return decoratee.load(request, completion: { [weak self] result in
            guard self != nil else { return }
            switch result {
                case let .success(body): completion(.success(body))
                case let .failure(error): completion(.failure(error))
            }
        })
    }
}

private extension AuthenticatedHTTPClientDecorator {
    func enrich(_ request: URLRequest, with config: APIConfig) -> URLRequest {

        guard let requestURL = request.url, var urlComponents = URLComponents(string: requestURL.absoluteString) else { return request }

        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        queryItems.append(.init(name: "api_key", value: config.secret))

        urlComponents.queryItems = queryItems

        guard let authenticatedRequestURL = urlComponents.url else { return request }

        var signedRequest = request
        signedRequest.url = authenticatedRequestURL
        return signedRequest
    }
}
