class TvShowDetailsViewModel {
    
    private var viewControllerDelegate:TvShowDetailsViewControllerDelegate?
    
    private var tvShow: TvShow
    private var seasons: [[Episode]] = []
    private var actors: [Actor] = []
    
    let service: TvMazeServiceProtocol!
    
    init(tvShow: TvShow, service: TvMazeServiceProtocol, viewControllerDelegate: TvShowDetailsViewControllerDelegate) {
        self.tvShow = tvShow
        self.service = service
        self.viewControllerDelegate = viewControllerDelegate
    }
    
    func loadData() {
        fetchActors()
        fetchEpisodes()
    }
    
    func getTvShow() -> TvShow {
        return tvShow
    }
    
    func getActorForIndex(index: Int) -> Actor {
        return actors[index]
    }
    
    func getNumberOfActors() -> Int {
        return actors.count
    }
    
    func getEpisodesForIndex(index: Int) -> [Episode] {
        return seasons[index]
    }
    
    func getNumberOfSeasons() -> Int {
        return seasons.count
    }
    
    func fetchActors() {
        service.getActors(tvShowId: tvShow.id ?? 0) { [self] result in
            do {
                self.actors = try result.get()
                self.viewControllerDelegate?.refreshActorsList()
            } catch (let error ){
                viewControllerDelegate?.showErrorAlert(error.localizedDescription)
            }
        }
    }
    
    func fetchEpisodes() {
        service.getEpisodes(id: tvShow.id ?? 0) { [self] result in
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
                let lastSeason = seasons[seasons.count - 1]
                
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
