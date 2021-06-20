//
//  News.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Foundation

struct News: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}

struct Article: Codable {
    var source: Article.Source
    var author: String?
    var title: String
    var description: String?
    var url: URL?
    var urlToImage: URL?
    var publishedAt: String?
    var content: String?

    struct Source: Codable {
        var id: String
        var name: String
    }
}
