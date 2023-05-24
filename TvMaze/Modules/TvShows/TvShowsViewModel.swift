public class TvShowsViewModel {
    
    private var viewControllerDelegate:TvShowsViewControllerDelegate?
    private var tvShows: [TvShow] = []
    private var tvMazeService: TvMazeServiceProtocol!
    
    public init(service: TvMazeServiceProtocol, viewControllerDelegate: TvShowsViewControllerDelegate) {
        self.tvMazeService = service
        self.viewControllerDelegate = viewControllerDelegate
    }
    
    public func fetchTvShows(page: Int) {
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
    
    public func searchTvShow(query: String) {
        viewControllerDelegate?.showLoading()
        tvMazeService.searchTvShow(query: query.lowercased()) { [self] result in
            viewControllerDelegate?.hideLoading()
            do {
                self.tvShows = try result.get()
                self.viewControllerDelegate?.refreshList()
            } catch (let error ){
                viewControllerDelegate?.showErrorAlert(error.localizedDescription)
            }
        }
    }
    
    public func getTvShowAtIndex(index: Int) -> TvShow {
        return tvShows[index]
    }
    
    public func getNumberOfRows() -> Int {
        return tvShows.count
    }
    
}
