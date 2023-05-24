//
//
// Created by André Vinícius Torres Conrado
//


import XCTest
@testable import TvMaze

final class TvShowsViewModelTests: XCTestCase {
    
    var sut: TvShowsViewModel!
    var mockService: TvMazeServiceMock!
    var mockTvShowsViewController: TvShowsViewControllerMock!

    override func setUpWithError() throws {
        mockService = TvMazeServiceMock()
        mockTvShowsViewController = TvShowsViewControllerMock()
        sut = TvShowsViewModel(service: mockService, viewControllerDelegate: mockTvShowsViewController)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockService = nil
        mockTvShowsViewController = nil
    }

    func testFechtTvShowsSuccess() {
        let tvShow1 = TvShow(id: 0, name: "Nome 1", image: ["Image": "url"], genres: ["teste1", "teste2"], summary: "description 1")
        let tvShow2 = TvShow(id: 1, name: "Nome 2", image: ["Image": "url"], genres: ["teste1", "teste2"], summary: "description 2")
        let list: [TvShow] = [tvShow1, tvShow2]

        mockService.getTvShowsResult = .success(list)
        sut.fetchTvShows(page: 0)

        XCTAssertTrue(mockTvShowsViewController.showLoadingCalled)
        XCTAssertTrue(mockTvShowsViewController.hideLoadingCalled)
        XCTAssertEqual(sut.getNumberOfRows(), list.count)
        XCTAssertTrue(mockTvShowsViewController.refreshListCalled)
    }
    
    func testFechtTvShowsFailure() {
        mockService.getTvShowsResult = .failure(NSError(domain: "com.test.error", code: 0))
        sut.fetchTvShows(page: 0)
        
        XCTAssertTrue(mockTvShowsViewController.showLoadingCalled)
        XCTAssertTrue(mockTvShowsViewController.hideLoadingCalled)
        XCTAssertTrue(mockTvShowsViewController.showErrorAlertCalled)
    }
    
    func testGetTvShowAtIndex() {
        let tvShow1 = TvShow(id: 0, name: "Nome 1", image: ["Image": "url"], genres: ["teste1", "teste2"], summary: "description 1")
        let tvShow2 = TvShow(id: 1, name: "Nome 2", image: ["Image": "url"], genres: ["teste1", "teste2"], summary: "description 2")
        let list: [TvShow] = [tvShow1, tvShow2]

        mockService.getTvShowsResult = .success(list)
        sut.fetchTvShows(page: 0)

        XCTAssertEqual(sut.getTvShowAtIndex(index: 0).name, "Nome 1")
        XCTAssertEqual(sut.getTvShowAtIndex(index: 1).name, "Nome 2")
    }
    
    func testGetNumberOfRows() {
        XCTAssertEqual(sut.getNumberOfRows(), 0)
    }
    
    func testFetchTvShows() {
        sut.fetchTvShows(page: 0)
    }
}

class TvShowsViewControllerMock: TvShowsViewControllerDelegate {
    
    var showLoadingCalled = false
    var hideLoadingCalled = false
    var refreshListCalled = false
    var showErrorAlertCalled = false

    func showLoading() {
        showLoadingCalled = true
    }
    
    func hideLoading() {
        hideLoadingCalled = true
    }
    
    func refreshList() {
        refreshListCalled = true
    }
    
    func showErrorAlert(_ message: String) {
        showErrorAlertCalled = true
    }
    
}

