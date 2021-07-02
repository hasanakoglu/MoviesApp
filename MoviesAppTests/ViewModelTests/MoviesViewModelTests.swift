import XCTest
@testable import MoviesApp

class MoviesViewModelTests: XCTestCase {
    var subject: MoviesViewModel!
    var mockURLSession: MockURLSession!
    var mockMovieRequest: MockMovieRequest!

    override func setUpWithError() throws {
        mockMovieRequest = MockMovieRequest()
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
        subject = MoviesViewModel(urlSession: mockURLSession, request: mockMovieRequest)
    }

    override func tearDownWithError() throws {
        subject = nil
    }
    
    func testFetchmovies() {
        mockMovieRequest.fetchMoviesCalled = true
        subject.fetchMovies {
        }
        XCTAssertEqual(subject.listOfMovies.count, 1)
    }
}

extension Movie {
    static func movieStub() -> Movie {
        return Movie(title: "name", year: "2021", rate: 2.0, posterImage: "", overview: "")
    }
}
