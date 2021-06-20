//
//  RecentNewsEndpoint.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Foundation
import Alamofire

enum RecentNewsEndpoint: Endpoint {

    case getRecentNews(source: String, page: Int)

    var baseURL: String {
        return "https://newsapi.org"
    }

    var method: HTTPMethod {
        switch self {
        case .getRecentNews:
            return .get
        }
    }

    var path: String {
        let apiKey = "19ac1fa5e69b45889a1988b85ffb3b69"
        switch self {
        case .getRecentNews(let source, let page):
            return "/v2/top-headlines?sources=\(source)&apiKey=\(apiKey)&page=\(page)"
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
