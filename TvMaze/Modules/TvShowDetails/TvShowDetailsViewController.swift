//
//  TvShowDetailsViewController.swift
//  TvMaze
//
//  Created by Vinicius Torres on 03/03/23.
//

import UIKit

protocol TvShowDetailsViewControllerDelegate {
    func showActorsLoading()
    func hideActorsLoading()
    func showEpisodesLoading()
    func hideEpisodesLoading()
    func refreshActorsList()
    func refreshEpisodesList()
    func showErrorAlert(_ message: String)
}

class TvShowDetailsViewController: UIViewController {
    
    var customView: TvShowDetailsView?
    var viewModel: TvShowDetailsViewModel!
    
    override func loadView() {
        self.customView = TvShowDetailsView()
        self.customView?.prepare(tvShow: viewModel.tvShow)
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewControllerDelegate = self
        viewModel.loadData()
        customView?.backButton.delegate = self
        customView?.viewDelegate = self
        customView?.setupGenresCollection(delegate: self, dataSource: self)
        customView?.setupActorsCollection(delegate: self, dataSource: self)
        customView?.setupEpisodesTable(delegate: self, dataSource: self)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    static func assembleModule(tvShow: TvShow) -> UIViewController {
        let viewController = TvShowDetailsViewController()
        let viewModel = TvShowDetailsViewModel(tvShow: tvShow)
        viewController.viewModel = viewModel
        return viewController
    }

}

extension TvShowDetailsViewController: TvShowDetailsViewControllerDelegate {
    
    func showActorsLoading() {
        
    }
    
    func hideActorsLoading() {
        
    }
    
    func showEpisodesLoading() {
        
    }
    
    func hideEpisodesLoading() {
        
    }
    
    func refreshActorsList() {
        customView?.actorsCollection.reloadData()
    }
    
    func refreshEpisodesList() {
        customView?.episodesTable.reloadData()
    }
    
    func showErrorAlert(_ message: String) {
        
    }
    
}

extension TvShowDetailsViewController: TvShowDetailsViewDelegate {
    
}

extension TvShowDetailsViewController: CustomBackButtonDelegate {
    
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension TvShowDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case customView?.actorsCollection:
            return viewModel.actors.count
        default:
            return viewModel.tvShow.genres.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case customView?.actorsCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionCell.identifier, for: indexPath) as! ActorCollectionCell
            cell.prepare(actor: viewModel.actors[indexPath.row])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionCell.identifier, for: indexPath) as! GenreCollectionCell
            cell.prepare(genre: viewModel.tvShow.genres[indexPath.row])
            return cell
        }
    }
    
}

extension TvShowDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodesTableCell.identifier, for: indexPath) as! EpisodesTableCell
        cell.prepare(season: viewModel.seasons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
}
