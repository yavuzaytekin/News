//
//  NewsSourcesWorker.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Foundation
import Alamofire

class NewsSourcesWorker {
    func getNewsSources(completionHandler: @escaping ((_ result: Swift.Result<Sources, ServiceError>) -> Void)) {
        Service.shared.execute(requestEndpoint: SourcesEndpoint.getSources, responseModel: Sources.self) { result in
            completionHandler(result)
        }
    }
}
