//
//
// Created by André Vinícius Torres Conrado
//


import XCTest
import TvMaze
import OHHTTPStubs

final class TvMazeServiceTests: XCTestCase {
    
    var sut: TvMazeServiceProtocol!

    override func setUpWithError() throws {
        sut = TvMazeService()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    
    //GetTvShows
    func testGetTvShowsSuccess() {
        let expectation = self.expectation(description: "get TvShows success")
        sut.getTvShows(page: 0) { result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success, "success can't be nil")
                XCTAssertGreaterThan(success.count, 0, "success sizes needs to be greater than 0")
                expectation.fulfill()
            case .failure:
                XCTFail("Request error")
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testGetHomeFailure() {
        let expectation = self.expectation(description: "get TvShows failure")
        
        HTTPStubs.stubRequests { request in
            request.url?.absoluteString.contains(TvMazeEndpoints.getTvShowsEndpoint) ?? false
        } withStubResponse: { _ in
            return HTTPStubsResponse(error: NSError(domain: "com.test.error", code: 404))
        }

        sut.getTvShows(page: 0) { result in
            switch result {
            case .success:
                XCTFail("Stub Error")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
        HTTPStubs.removeAllStubs()
    }

    //GetEpisodes
    func testGetEpisodesSuccess() {
        let expectation = self.expectation(description: "get Episodes success")
        sut.getEpisodes(id: 1) { result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success, "success can't be nil")
                XCTAssertGreaterThan(success.count, 0, "success sizes needs to be greater than 0")
                expectation.fulfill()
            case .failure:
                XCTFail("Request error")
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testGetEpisodesFailure() {
        let expectation = self.expectation(description: "get Episodes failure")

        HTTPStubs.stubRequests { request in
            request.url?.absoluteString.contains(TvMazeEndpoints.getEpisodesEndpoint) ?? false
        } withStubResponse: { _ in
            return HTTPStubsResponse(error: NSError(domain: "com.test.error", code: 404))
        }

        sut.getEpisodes(id: 1) { result in
            switch result {
            case .success:
                XCTFail("Stub Error")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
        HTTPStubs.removeAllStubs()
    }

    //SearchTvShow
    func testSearchTvShowSuccess() {
        let expectation = self.expectation(description: "search TvShow success")
        sut.searchTvShow(query: "arrow") { result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success, "success can't be nil")
                XCTAssertGreaterThan(success.count, 0, "success sizes needs to be greater than 0")
                expectation.fulfill()
            case .failure:
                XCTFail("Request error")
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testSearchTvShowFailure() {
        let expectation = self.expectation(description: "search TvShow failure")

        HTTPStubs.stubRequests { request in
            request.url?.absoluteString.contains(TvMazeEndpoints.searchTvShowEndpoint) ?? false
        } withStubResponse: { _ in
            return HTTPStubsResponse(error: NSError(domain: "com.test.error", code: 404))
        }

        sut.searchTvShow(query: "test") { result in
            switch result {
            case .success:
                XCTFail("Stub Error")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
        HTTPStubs.removeAllStubs()
    }
    
    // GetActors
    func testGetActorsSuccess() {
        let expectation = self.expectation(description: "get Actors success")
        sut.getActors(tvShowId: 1) { result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success, "success can't be nil")
                XCTAssertGreaterThan(success.count, 0, "success sizes needs to be greater than 0")
                expectation.fulfill()
            case .failure:
                XCTFail("Request error")
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testGetActorsFailure() {
        let expectation = self.expectation(description: "get Actors failure")

        HTTPStubs.stubRequests { request in
            request.url?.absoluteString.contains(TvMazeEndpoints.getActorsEndpoint) ?? false
        } withStubResponse: { _ in
            return HTTPStubsResponse(error: NSError(domain: "com.test.error", code: 404))
        }

        sut.getActors(tvShowId: 1) { result in
            switch result {
            case .success:
                XCTFail("Stub Error")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
        HTTPStubs.removeAllStubs()
    }

}
