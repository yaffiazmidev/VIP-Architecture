//
//  SceneDelegate+HTTPClient.swift
//  VIP-Architecture
//
//  Created by DENAZMI on 09/10/24.
//

import Foundation

extension SceneDelegate {
    func makeHTTPClient(with config: APIConfig = .init(secret: "")) -> (httpClient: HTTPClient, authHTTPClient: AuthenticatedHTTPClientDecorator) {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForRequest = 10.0
        configuration.timeoutIntervalForResource = 10.0
        
        let httpClient = URLSessionHTTPClient(session: URLSession(configuration: configuration))
        let authHTTPClient = AuthenticatedHTTPClientDecorator(decoratee: httpClient, config: config)
        
        return (httpClient, authHTTPClient)
    }
}
