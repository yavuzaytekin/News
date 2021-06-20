//
//  NewsSourcesModels.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Foundation

enum NewsSources {
    enum Fetch {
        struct Request { }

        struct Response {
            var sources: [Source]
        }

        struct ViewModel {
            var sources: [NewsSources.Fetch.ViewModel.Source] = []

            struct Source {
                var name: String
                var description: String
            }
        }
    }

    enum ShowNews {
        struct Request {
            var index: Int
        }

        struct Response { }
        struct ViewModel { }
    }
}
