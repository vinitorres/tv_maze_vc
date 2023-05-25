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
        waitForExpectations(timeout: 30)
    }
    
    func testGetShowsFailure() {
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
        waitForExpectations(timeout: 30)
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
        waitForExpectations(timeout: 30)
    }

    func testGetEpisodesFailure() {
        let expectation = self.expectation(description: "get Episodes failure")
        
        let url = TvMazeEndpoints.getEpisodesEndpoint.replacingOccurrences(of: "{id}", with: "1")

        HTTPStubs.stubRequests { request in
            request.url?.absoluteString.contains(url) ?? false
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
        waitForExpectations(timeout: 30)
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
        waitForExpectations(timeout: 30)
    }

    func testGetActorsFailure() {
        let expectation = self.expectation(description: "get Actors failure")
        
        let url = TvMazeEndpoints.getActorsEndpoint.replacingOccurrences(of: "{id}", with: "1")

        HTTPStubs.stubRequests { request in
            request.url?.absoluteString.contains(url) ?? false
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
        waitForExpectations(timeout: 30)
        HTTPStubs.removeAllStubs()
    }

}
