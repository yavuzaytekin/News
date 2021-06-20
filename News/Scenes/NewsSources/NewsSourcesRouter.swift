//
//  NewsSourcesRouter.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import Foundation
import UIKit

protocol NewsSourcesRoutingLogic: class {
    func routeToRecentNews(sourceIndex: Int)
}

protocol NewsSourcesDataPassing: class {
    var dataStore: NewsSourcesDataStore? { get }
}

class NewsSourcesRouter: NewsSourcesRoutingLogic, NewsSourcesDataPassing {

    weak var viewController: NewsSourcesViewController?
    var dataStore: NewsSourcesDataStore?

    func routeToRecentNews(sourceIndex: Int) {
        let recentNewsViewController: RecentNewsViewController = UIApplication.getViewController()
        recentNewsViewController.router?.dataStore?.selectedSource = self.dataStore?.sources[sourceIndex]
//        recentNewsViewController.router?.delegate = delegate
        viewController?.navigationController?.pushViewController(recentNewsViewController, animated: true)
    }

}
