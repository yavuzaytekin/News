//
//  Endpoint.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Alamofire

public protocol Endpoint: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
