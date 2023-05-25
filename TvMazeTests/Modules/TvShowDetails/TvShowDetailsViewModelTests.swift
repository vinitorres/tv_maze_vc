//
//
// Created by André Vinícius Torres Conrado
//


import XCTest
@testable import TvMaze

final class TvShowDetailsViewModelTests: XCTestCase {
    
    var sut: TvShowDetailsViewModel!
    var mockService: TvMazeServiceMock!
    var mockTvShowDetailsViewController: TvShowDetailsViewControllerDelegateMock!
    
    let tvShow = TvShow(id: 0, name: "Nome 1", image: ["Image": "url"], premiered: "", ended: "", genres: ["teste1", "teste2"],summary: "description 1")
    
    override func setUpWithError() throws {
        mockService = TvMazeServiceMock()
        mockTvShowDetailsViewController = TvShowDetailsViewControllerDelegateMock()
        sut = TvShowDetailsViewModel(tvShow: tvShow, service: mockService, viewControllerDelegate: mockTvShowDetailsViewController)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockService = nil
        mockTvShowDetailsViewController = nil
    }
    
    func testLoadActorsSuccess() {
        let actor1 = Actor(id: 0, name: "Nome 1", image: ["Image": "url"])
        let actor2 = Actor(id: 1, name: "Nome 2", image: ["Image": "url"])
        let list: [Actor] = [actor1, actor2]

        mockService.getActorsResult = .success(list)
        sut.fetchActors()

        XCTAssertEqual(sut.getNumberOfActors(), list.count)
        XCTAssertTrue(mockTvShowDetailsViewController.refreshActorsListCalled)
    }

    func testLoadActorsFailure() {
        mockService.getActorsResult = .failure(NSError(domain: "com.test.error", code: 0))
        sut.fetchActors()

        XCTAssertTrue(mockTvShowDetailsViewController.showErrorAlertCalled)
    }
    
    func testLoadEpisodesSuccess() {
        let episode1 = Episode(id: 0, name: "Nome 1", number: 1, season: 1, summary: "description", image: ["Image": "url"])
        let episode2 = Episode(id: 1, name: "Nome 2", number: 2, season: 1, summary: "description", image: ["Image": "url"])
        let list: [Episode] = [episode1, episode2]

        mockService.getEpisodesResult = .success(list)
        sut.fetchEpisodes()

        XCTAssertEqual(sut.getNumberOfSeasons(), 1)
        XCTAssertTrue(mockTvShowDetailsViewController.refreshEpisodesListCalled)
    }

    func testLoadEpisodesFailure() {
        mockService.getEpisodesResult = .failure(NSError(domain: "com.test.error", code: 0))
        sut.fetchEpisodes()

        XCTAssertTrue(mockTvShowDetailsViewController.showErrorAlertCalled)
    }
    
}

class TvShowDetailsViewControllerDelegateMock: TvShowDetailsViewControllerDelegate {

    var refreshActorsListCalled = false
    var refreshEpisodesListCalled = false
    var showErrorAlertCalled = false
    
    func refreshActorsList() {
        refreshActorsListCalled = true
    }
    
    func refreshEpisodesList() {
        refreshEpisodesListCalled = true
    }
    
    func showErrorAlert(_ message: String) {
        showErrorAlertCalled = true
    }
     
}
