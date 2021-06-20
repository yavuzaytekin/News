//
//  Service.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Foundation
import Alamofire

public enum ServiceError: Error {
    case parseError
    case badUrlError
    case badRequestError
}

public protocol ServiceProtocol {
    func execute<M: Codable>(requestEndpoint: Endpoint,
                             responseModel: M.Type,
                             completion: @escaping (Swift.Result<M, ServiceError>) -> Void)
}

public class Service: ServiceProtocol {

    public static let shared = Service()

    public func execute<M: Codable>(requestEndpoint: Endpoint,
                                    responseModel: M.Type,
                                    completion: @escaping (Swift.Result<M, ServiceError>) -> Void) {
        do {
            let urlRequest = try requestEndpoint.asURLRequest()
            Alamofire.request(urlRequest).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        let jsonResults = try JSONDecoder().decode(responseModel, from: jsonData)
                        completion(.success(jsonResults))
                    } catch {
                        completion(.failure(.parseError))
                    }
                case .failure:
                    completion(.failure(.badRequestError))
                }
            }
        } catch {
            completion(.failure(.badUrlError))
        }
    }
}
