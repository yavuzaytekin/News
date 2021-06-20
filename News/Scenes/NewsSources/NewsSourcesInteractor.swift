//
//  NewsSourcesInteractor.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Foundation

protocol NewsSourcesBusinessLogic: class {
    func fetchNewsSources(request: NewsSources.Fetch.Request)
}

protocol NewsSourcesDataStore: class {
    var sources: [Source] { get }
    var selectedSource: Source? { get }
}

class NewsSourcesInteractor: NewsSourcesBusinessLogic, NewsSourcesDataStore {

    var presenter: NewsSourcesPresentationLogic?
    var worker: NewsSourcesWorker = NewsSourcesWorker()

    var sources: [Source] = []
    var selectedSource: Source?

    func fetchNewsSources(request: NewsSources.Fetch.Request) {
        worker.getNewsSources { result in
            switch result {
            case .success(let newsSources):
                self.sources = newsSources.sources
                self.presenter?.presentNewsSources(response: NewsSources.Fetch.Response(sources: newsSources.sources))
            case .failure(let error):
                print(error)
            }

        }
    }
}
