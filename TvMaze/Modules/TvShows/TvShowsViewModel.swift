class TvShowsViewModel {
    
    private var viewControllerDelegate:TvShowsViewControllerDelegate?
    private var tvShows: [TvShow] = []
    
    let tvMazeService: TvMazeServiceProtocol!
    
    init(service: TvMazeServiceProtocol!) {
        self.tvMazeService = service
    }
    
    public func setViewControllerDelegate(delegate: TvShowsViewControllerDelegate) {
        self.viewControllerDelegate = delegate
    }
    
    func fetchTvShows(page: Int) {
        viewControllerDelegate?.showLoading()
        tvMazeService.getTvShows(page: page) { [self] result in
            viewControllerDelegate?.hideLoading()
            do {
                self.tvShows = try result.get()
                self.viewControllerDelegate?.refreshList()
            } catch (let error ){
                viewControllerDelegate?.showErrorAlert(error.localizedDescription)
            }
        }
    }
    
    func getTvShowAtIndex(index: Int) -> TvShow {
        return self.tvShows[index]
    }
    
    func getNumberOfRows() -> Int {
        return self.tvShows.count
    }
    
}
