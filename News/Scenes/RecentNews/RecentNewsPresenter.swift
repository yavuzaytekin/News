//
//  RecentNewsPresenter.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Foundation

protocol RecentNewsPresentationLogic: class {
    func presentRecentNews(response: RecentNews.Fetch.Response, favouriteNewsTitles: [String])
}

final class RecentNewsPresenter: RecentNewsPresentationLogic {
    weak var viewController: RecentNewsDisplayLogic?

    func presentRecentNews(response: RecentNews.Fetch.Response, favouriteNewsTitles: [String]) {
        let news: [RecentNews.Fetch.ViewModel.News] = response.news.map({ article in
            let isAdded = favouriteNewsTitles.contains(article.title)
            let tempNews = RecentNews.Fetch.ViewModel.News(title: article.title,
                                                           description: article.description,
                                                           image: article.urlToImage,
                                                           isAdded: isAdded)
            return tempNews
        })
        viewController?.displayRecentNews(viewModel: RecentNews.Fetch.ViewModel(news: news))
    }
}
