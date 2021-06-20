//
//  RecentNewsViewController.swift
//  News
//
//  Created by Yavuz on 17.06.2021.
//

import UIKit
import Kingfisher

protocol RecentNewsDisplayLogic: class {
    func displayRecentNews(viewModel: RecentNews.Fetch.ViewModel)
}

class RecentNewsViewController: UIViewController {

    var interactor: RecentNewsBusinessLogic?
    var router: (RecentNewsRoutingLogic & RecentNewsDataPassing)?

    @IBOutlet weak var tableView: UITableView!

    var news: [RecentNews.Fetch.ViewModel.News] = []

    var isFetching = false

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
        let interactor = RecentNewsInteractor()
        let presenter = RecentNewsPresenter()
        let router = RecentNewsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        isFetching = true
        interactor?.fetchRecentNews(request: RecentNews.Fetch.Request())
        updateNews()
    }

    func setupTableView() {
        tableView.register(UINib(nibName: "RecentNewsCell", bundle: nil), forCellReuseIdentifier: "RecentNewsCell")
    }

    func updateNews() {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.isFetching = true
            self.interactor?.fetchRecentNews(request: RecentNews.Fetch.Request())
        }
    }

    func changeFavouriteNewsStatus(cell: UITableViewCell, indexPath: IndexPath) {
        if let newsCell = cell as? RecentNewsCell {
            let isAdded = !news[indexPath.row].isAdded
            news[indexPath.row].isAdded = isAdded
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                newsCell.isAdded = isAdded
                self.tableView.reloadData()
            }
            interactor?.saveRecentFavouriteNews(with: news[indexPath.row].title, isAdded: isAdded)
        }
    }
}

extension RecentNewsViewController: RecentNewsDisplayLogic {
    func displayRecentNews(viewModel: RecentNews.Fetch.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.news += viewModel.news
            self.tableView.reloadData()
            self.isFetching = false
        }
    }
}

extension RecentNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RecentNewsCell") as? RecentNewsCell {
            cell.set(with: news[indexPath.row])
            cell.setIsAddedTapAction { [weak self] newsCell in
                guard let self = self else { return }
                self.changeFavouriteNewsStatus(cell: newsCell, indexPath: indexPath)
            }
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // It fetch image from url and load to memory if there is an image before the cell displays
        if let cell = cell as? RecentNewsCell {
            let url = news[indexPath.row].image
            let processor = DownsamplingImageProcessor(size: cell.newsImageView.bounds.size)
            
            cell.newsImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ], completionHandler: nil)
        }
        // It fetchs news if last item seen
        if !isFetching && indexPath.row == news.count - 1 {
            interactor?.fetchRecentNews(request: RecentNews.Fetch.Request())
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToWebSite(with: indexPath.row)
    }
}
