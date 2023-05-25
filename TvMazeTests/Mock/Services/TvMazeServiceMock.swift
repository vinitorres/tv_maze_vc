//
//
// Created by André Vinícius Torres Conrado
//

import TvMaze

class TvMazeServiceMock: TvMazeServiceProtocol {
    
    var getTvShowsResult: Result<[TvShow], Error> = .success([])
    var getEpisodesResult: Result<[Episode], Error> = .success([])
    var getActorsResult: Result<[Actor], Error> = .success([])
    var searchTvShowResult: Result<[TvMaze.TvShow], Error> = .success([])
    
    func getTvShows(page: Int, completion: @escaping (Result<[TvMaze.TvShow], Error>) -> Void) {
        completion(getTvShowsResult)
    }
    
    func getEpisodes(id: Int, completion: @escaping (Result<[TvMaze.Episode], Error>) -> Void) {
        completion(getEpisodesResult)
    }
    
    func getActors(tvShowId: Int, completion: @escaping (Result<[TvMaze.Actor], Error>) -> Void) {
        completion(getActorsResult)
    }
    
    func searchTvShow(query: String, completion: @escaping (Result<[TvMaze.TvShow], Error>) -> Void) {
        completion(searchTvShowResult)
    }
    
}
