class TvShowDetailsViewModel {
    
    var viewControllerDelegate:TvShowDetailsViewControllerDelegate?
    
    var tvShow: TvShow
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
                self.seasons = prepareSeasonList(episodes: try result.get())
                self.viewControllerDelegate?.refreshEpisodesList()
            } catch (let error ){
                viewControllerDelegate?.showErrorAlert(error.localizedDescription)
            }
        }
    }
    
    private func prepareSeasonList(episodes: [Episode]) -> [[Episode]] {
        var temps = [[Episode]]()
        for episode in episodes {
            if temps.isEmpty {
                temps.append([episode])
            } else {
                var lastSeason = temps[temps.count - 1]
                
                if lastSeason[0].season == episode.season {
                    temps[temps.count - 1].append(episode)
                } else {
                    temps.append([episode])
                }
            }
        }
        
        return temps
    }
    
}
