import Foundation
import XCTest

@testable import MoviesApp

class MovieRequestTests: XCTestCase {
    var subject: MoviesRequest!
    var mockURLSession: MockURLSession!
    var mockmovieRequest: MockMovieRequest!
    
    override func setUp() {
        mockmovieRequest = MockMovieRequest()
        mockURLSession = MockURLSession(data: MovieRequestTests.mockData, urlResponse: nil, error: nil)
        subject = MoviesRequest(session: mockURLSession)
    }

    override func tearDown() {
        subject = nil
    }
    
    func testFetchmoviesSuccess() {
        var result: Result<[Movie], MoviesError>?
        let expectation = XCTestExpectation(description: #function)
        subject.fetchMovies { fetchedResult in
            result = fetchedResult
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
   
        XCTAssertNotNil(result?.value)
        XCTAssertNil(result?.error)
    }
    

    func testFetchmoviesFailure() {
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
        subject = MoviesRequest(session: mockURLSession)
        var result: Result<[Movie], MoviesError>?
        let expectation = XCTestExpectation(description: #function)
        subject.fetchMovies { fetchedResult in
            result = fetchedResult
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)

        XCTAssertNil(result?.value)
        XCTAssertNotNil(result?.error)
        XCTAssertNotNil(MoviesError.noData)
    }
}

extension MovieRequestTests {
    static var mockData: Data {
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: "movies", ofType: "json")!
        return FileManager().contents(atPath: path)!
    }
}

