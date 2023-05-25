//
//
// Created by André Vinícius Torres Conrado
//


class EpisodeDetailsViewModel {
    
    private let episode: Episode
    
    init(episode: Episode) {
        self.episode = episode
    }
    
    func getEpisode() -> Episode {
        return episode
    }
    
}
