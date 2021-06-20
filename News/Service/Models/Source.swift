//
//  Source.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Foundation

struct Source: Codable {
    var id: String
    var name: String
    var description: String
    var url: URL
    var category: String
    var language: String
    var country: String
}
