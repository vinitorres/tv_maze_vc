import UIKit

protocol TvShowsViewControllerDelegate {
    func showLoading()
    func hideLoading()
    func refreshList()
    func showErrorAlert(_ message: String)
}

class TvShowsViewController: UIViewController {
    
    private var customView: TvShowsView?
    private var viewModel: TvShowsViewModel?
    
    private var page = 0
    
    override func loadView() {
        self.customView = TvShowsView()
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TV Shows"
        viewModel?.setViewControllerDelegate(delegate: self)
        viewModel?.fetchTvShows(page: page)
        customView?.setCollectionViewDelegate(self)
        customView?.setCollectionViewDataSource(self)
    }
    
    static func assembleModule() -> UIViewController {
        let viewController = TvShowsViewController()
        let service = TvMazeService()
        let viewModel = TvShowsViewModel(service: service)
        viewController.viewModel = viewModel
        return viewController
    }

}

extension TvShowsViewController: TvShowsViewControllerDelegate {
    
    func showLoading() {
        customView?.showLoading()
    }
    
    func hideLoading() {
        customView?.hideLoading()
    }
    
    func refreshList() {
        customView?.collectionView.reloadData()
    }
    
    func showErrorAlert(_ message: String) {
        let alertError = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        self.present(alertError, animated: true, completion: nil)
    }
    
}

extension TvShowsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TvShowCollectionCell.identifier, for: indexPath) as! TvShowCollectionCell
        guard let tvShow = viewModel?.getTvShowAtIndex(index: indexPath.row) else { return UICollectionViewCell() }
        cell.prepare(tvShow: tvShow)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tvShowSelected = viewModel?.getTvShowAtIndex(index: indexPath.row) else { return }
        let vc = TvShowDetailsViewController.assembleModule(tvShow: tvShowSelected)
        self.navigationController?.show(vc , sender: self)
    }
    
}
