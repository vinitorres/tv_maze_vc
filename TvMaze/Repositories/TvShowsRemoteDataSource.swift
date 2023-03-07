//
//  TvShowsRemoteDataSource.swift
//  TvMazeSwiftUI
//


import Foundation

protocol TvMazeRemoteDataSourceProtocol {
    //func getTvShows(page: Int) async throws -> [TvShow]
//  func searchTvShows(name: String, page: Int?) async throws -> [TvShow]
//  func getEpisodes(tvShowId: Int) async throws -> [Episode]
//  func getActors(tvShowId: Int) async throws -> [Actor]
//  func getActorSeries(actorId: Int) async throws -> [TvShow]
}

class TvMazeRemoteDataSource: TvMazeRemoteDataSourceProtocol {
    
  let tvShowsService: TvMazeService
  
  init(tvShowsService: TvMazeService = TvMazeService()) {
    self.tvShowsService = tvShowsService
  }
  
}
