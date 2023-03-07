class TvShowDetailsViewModel {
    
    var viewControllerDelegate:TvShowDetailsViewControllerDelegate?
    
    var tvShow: TvShow
    var episodes: [Episode] = []
    var seasons: [[Episode]] = []
    var actors: [Actor] = []
    
    let tvMazeService = TvMazeService()
    
    init(tvShow: TvShow) {
        self.tvShow = tvShow
    }
    
    func loadData() {
        loadActors()
        loadEpisodes()
    }
    
    func loadActors() {
        viewControllerDelegate?.showActorsLoading()
        tvMazeService.getActors(tvShowId: tvShow.id) { [self] result in
            viewControllerDelegate?.hideActorsLoading()
            do {
                self.actors = try result.get()
                self.viewControllerDelegate?.refreshActorsList()
            } catch (let error ){
                viewControllerDelegate?.showErrorAlert(error.localizedDescription)
            }
        }
    }
    
    func loadEpisodes() {
        viewControllerDelegate?.showEpisodesLoading()
        tvMazeService.getEpisodes(id: tvShow.id) { [self] result in
            viewControllerDelegate?.hideEpisodesLoading()
            do {
                self.episodes = try result.get()
                prepareSeasonList()
                self.viewControllerDelegate?.refreshEpisodesList()
            } catch (let error ){
                viewControllerDelegate?.showErrorAlert(error.localizedDescription)
            }
        }
    }
    
    private func prepareSeasonList() {
        for episode in episodes {
            if seasons.isEmpty {
                seasons.append([episode])
            } else {
                var lastSeason = seasons.last
                if lastSeason?.first?.season == episode.season {
                    lastSeason?.append(episode)
                } else {
                    seasons.append([episode])
                }
            }
        }
        
        print("number of seasons: \(seasons.count)")
    }
    
}
