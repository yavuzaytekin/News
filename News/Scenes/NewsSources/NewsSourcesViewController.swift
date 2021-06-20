//
//  NewsSourcesViewController.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import UIKit

protocol NewsSourcesDisplayLogic: class {
    func displayNewsSources(viewModel: NewsSources.Fetch.ViewModel)
}

class NewsSourcesViewController: UIViewController {

    var interactor: NewsSourcesBusinessLogic?
    var router: (NewsSourcesRoutingLogic & NewsSourcesDataPassing)?

    @IBOutlet weak var tableView: UITableView!

    var sources: [NewsSources.Fetch.ViewModel.Source] = []

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = NewsSourcesInteractor()
        let presenter = NewsSourcesPresenter()
        let router = NewsSourcesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchNewsSources(request: NewsSources.Fetch.Request())
    }
}

extension NewsSourcesViewController: NewsSourcesDisplayLogic {
    func displayNewsSources(viewModel: NewsSources.Fetch.ViewModel) {
        self.sources = viewModel.sources
        self.tableView.reloadData()
    }
}

extension NewsSourcesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sources.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSourcesCell")!
        cell.textLabel?.text = sources[indexPath.row].name
        cell.detailTextLabel?.text = sources[indexPath.row].description

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToRecentNews(sourceIndex: indexPath.row)
    }

}
