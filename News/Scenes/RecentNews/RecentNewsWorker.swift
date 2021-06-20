//
//  RecentNewsWorker.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Foundation
import Alamofire

class RecentNewsWorker {
    // Network
    func getRecentNews(source: String, page: Int, completionHandler: @escaping ((_ result: Swift.Result<News, ServiceError>) -> Void)) {
        Service.shared.execute(requestEndpoint: RecentNewsEndpoint.getRecentNews(source: source, page: page), responseModel: News.self) { result in
            completionHandler(result)
        }
    }

    // Database
    func getFavouriteNews() -> [String] {
        let defaults = UserDefaults.standard
        if let favouriteNews = defaults.object(forKey: "FavouriteNews") as? [String] {
            return favouriteNews
        }
        return []
    }

    func addFavouriteNews(with title: String) {
        let defaults = UserDefaults.standard
        var news = getFavouriteNews()
        news.append(title)
        defaults.set(news, forKey: "FavouriteNews")
    }

    func removeFavouriteNews(with title: String) {
        let defaults = UserDefaults.standard
        var news = getFavouriteNews()
        news = news.filter({!$0.elementsEqual(title)})
        defaults.set(news, forKey: "FavouriteNews")
    }
}
