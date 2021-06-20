//
//  RecentNewsRouter.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Foundation
import SafariServices

protocol RecentNewsRoutingLogic: class {
    func routeToWebSite(with index: Int)
}

protocol RecentNewsDataPassing: class {
    var dataStore: RecentNewsDataStore? { get }
}

final class RecentNewsRouter: RecentNewsRoutingLogic, RecentNewsDataPassing {

    weak var viewController: RecentNewsViewController?
    var dataStore: RecentNewsDataStore?

    func routeToWebSite(with index: Int) {
        guard let news = dataStore?.news[index] else { return }
        if let url = news.url {
            let controller = SFSafariViewController.init(url: url)
            viewController?.present(controller, animated: true, completion: nil)
        }
    }
}
