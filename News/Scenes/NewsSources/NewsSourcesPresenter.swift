//
//  NewsSourcesPresenter.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Foundation

protocol NewsSourcesPresentationLogic: class {
    func presentNewsSources(response: NewsSources.Fetch.Response)
}

class NewsSourcesPresenter: NewsSourcesPresentationLogic {

    weak var viewController: NewsSourcesDisplayLogic?

    func presentNewsSources(response: NewsSources.Fetch.Response) {
        let sources: [NewsSources.Fetch.ViewModel.Source] = response.sources.map({ NewsSources.Fetch.ViewModel.Source(name: $0.name,
                                                                                                                      description: $0.description) })

        viewController?.displayNewsSources(viewModel: NewsSources.Fetch.ViewModel(sources: sources))
    }

}
