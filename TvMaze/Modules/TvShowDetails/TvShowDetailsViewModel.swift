class TvShowDetailsViewModel {
    
    var viewControllerDelegate:TvShowDetailsViewControllerDelegate?
    
    var tvShow: TvShow
    var seasons: [[Episode]] = []
    var actors: [Actor] = []
    
    let service: TvMazeServiceProtocol!
    
    init(tvShow: TvShow, service: TvMazeServiceProtocol) {
        self.tvShow = tvShow
        self.service = service
    }
    
    func loadData() {
        loadActors()
        loadEpisodes()
    }
    
    func loadActors() {
        viewControllerDelegate?.showActorsLoading()
        service.getActors(tvShowId: tvShow.id) { [self] result in
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
        service.getEpisodes(id: tvShow.id) { [self] result in
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
        var seasons = [[Episode]]()
        for episode in episodes {
            if seasons.isEmpty {
                seasons.append([episode])
            } else {
                var lastSeason = seasons[seasons.count - 1]
                
                if lastSeason[0].season == episode.season {
                    seasons[seasons.count - 1].append(episode)
                } else {
                    seasons.append([episode])
                }
            }
        }
        
        return seasons
    }
    
}
