import Foundation
import XCTest

@testable import MoviesApp

class MovieRequestTests: XCTestCase {
    var subject: MoviesRequest!
    var mockURLSession: MockURLSession!
    var mockMovieRequest: MockMovieRequest!
    
    override func setUp() {
        mockMovieRequest = MockMovieRequest()
        mockURLSession = MockURLSession(data: MovieRequestTests.mockData, urlResponse: nil, error: nil)
        subject = MoviesRequest(session: mockURLSession)
    }

    override func tearDown() {
        subject = nil
    }
    
    func testFetchMoviesSuccess() {
        var result: Result<[Movie], MoviesError>?
        let expectation = XCTestExpectation(description: #function)
        subject.fetchMovies { fetchedResult in
            result = fetchedResult
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
   
        XCTAssertNotNil(result?.value)
        XCTAssertNil(result?.error)
    }
    

    func testFetchMoviesFailure() {
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
        subject = MoviesRequest(session: mockURLSession)
        var result: Result<[Movie], MoviesError>?
        let expectation = XCTestExpectation(description: #function)
        subject.fetchMovies { fetchedResult in
            result = fetchedResult
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)

        XCTAssertNil(result?.value)
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

