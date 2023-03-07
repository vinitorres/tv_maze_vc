class TvShowsViewModel {
    
    var viewControllerDelegate:TvShowsViewControllerDelegate?
    var tvShows: [TvShow] = []
    
    let tvMazeService = TvMazeService()
    
    func loadData() {
        viewControllerDelegate?.showLoading()
        tvMazeService.getTvShows { [self] result in
            viewControllerDelegate?.hideLoading()
            do {
                self.tvShows = try result.get()
                self.viewControllerDelegate?.refreshList()
            } catch (let error ){
                viewControllerDelegate?.showErrorAlert(error.localizedDescription)
            }
        }
        
    }
    
}
