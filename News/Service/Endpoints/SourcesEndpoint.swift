//
//  SourcesEndpoint.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Foundation
import Alamofire

enum SourcesEndpoint: Endpoint {

    case getSources

    var baseURL: String {
        return "https://newsapi.org"
    }

    var method: HTTPMethod {
        switch self {
        case .getSources:
            return .get
        }
    }

    var path: String {
        let apiKey = "19ac1fa5e69b45889a1988b85ffb3b69"
        switch self {
        case .getSources:
            return "/v2/sources?apiKey=\(apiKey)"
        }
    }

    var parameters: Parameters? {
        return nil
    }

    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.appending(path).asURL()

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }
}
