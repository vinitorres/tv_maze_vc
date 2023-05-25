import UIKit

public protocol TvShowsViewControllerDelegate {
    func showLoading()
    func hideLoading()
    func refreshList()
    func showErrorAlert(_ message: String)
}

final public class TvShowsViewController: UIViewController {
    
    private var customView: TvShowsView?
    private var viewModel: TvShowsViewModel?
    
    private var page = 0
    
    public override func loadView() {
        self.customView = TvShowsView()
        self.view = customView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TV Shows"
        viewModel?.fetchTvShows(page: page)
        customView?.setSearchFieldDelegate(self)
        customView?.setCollectionViewDelegate(self)
        customView?.setCollectionViewDataSource(self)
    }
    
    static func assembleModule() -> UIViewController {
        let viewController = TvShowsViewController()
        let service = TvMazeService()
        let viewModel = TvShowsViewModel(service: service, viewControllerDelegate: viewController)
        viewController.viewModel = viewModel
        return viewController
    }
    
    func searchTvShows(_ query: String) {
        viewModel?.searchTvShow(query: query)
    }

}

extension TvShowsViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let query = textField.text {
            searchTvShows(query)
        }
        return true
    }
}

extension TvShowsViewController: TvShowsViewControllerDelegate {
    
    public func showLoading() {
        customView?.showLoading()
    }
    
    public func hideLoading() {
        customView?.hideLoading()
    }
    
    public func refreshList() {
        customView?.collectionView.reloadData()
    }
    
    public func showErrorAlert(_ message: String) {
        AlertManager.showErrorAlert(sender: self, message: message)
    }
    
}

extension TvShowsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows() ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TvShowCollectionCell.identifier, for: indexPath) as! TvShowCollectionCell
        guard let tvShow = viewModel?.getTvShowAtIndex(index: indexPath.row) else { return UICollectionViewCell() }
        cell.prepareForReuse()
        cell.prepare(tvShow: tvShow)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tvShowSelected = viewModel?.getTvShowAtIndex(index: indexPath.row) else { return }
        let vc = TvShowDetailsViewController.assembleModule(tvShow: tvShowSelected)
        self.navigationController?.show(vc , sender: self)
    }
    
}
