//
//  RecentNewsModels.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Foundation

enum RecentNews {
    enum Fetch {
        struct Request { }
        struct Response {
            var news: [Article]
        }

        struct ViewModel {

            var news: [RecentNews.Fetch.ViewModel.News] = []

            struct News {
                var title: String
                var description: String?
                var image: URL?
                var isAdded: Bool
            }
        }

    }
}
