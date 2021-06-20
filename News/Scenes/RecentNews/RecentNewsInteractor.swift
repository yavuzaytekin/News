//
//  RecentNewsInteractor.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Foundation

protocol RecentNewsBusinessLogic: class {
    func fetchRecentNews(request: RecentNews.Fetch.Request)
    func saveRecentFavouriteNews(with title: String, isAdded: Bool)
}

protocol RecentNewsDataStore: class {
    var news: [Article] { get }
    var selectedSource: Source? { get set }
    var page: Int { get set }
    var totalResults: Int { get }
}

class RecentNewsInteractor: RecentNewsBusinessLogic, RecentNewsDataStore {

    var presenter: RecentNewsPresentationLogic?
    var worker: RecentNewsWorker = RecentNewsWorker()

    var news: [Article] = []
    var selectedSource: Source?
    var page = 1
    var totalResults = -1

    func fetchRecentNews(request: RecentNews.Fetch.Request) {
        guard totalResults != news.count else { return }
        let favouriteNewsTitles = worker.getFavouriteNews()
        worker.getRecentNews(source: selectedSource!.id, page: page) { result in
            switch result {
            case .success(let news):
                self.totalResults = news.totalResults
                self.news = news.articles
                self.presenter?.presentRecentNews(response: RecentNews.Fetch.Response(news: news.articles),
                                                  favouriteNewsTitles: favouriteNewsTitles)
                self.page += 1
            case .failure(let error):
                print(error)
            }
        }
    }

    func saveRecentFavouriteNews(with title: String, isAdded: Bool) {
        if isAdded {
            worker.addFavouriteNews(with: title)
        } else {
            worker.removeFavouriteNews(with: title)
        }
    }
}
