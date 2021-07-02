import Foundation

@testable import MoviesApp

class MockMovieRequest: MoviesRequestProtocol {
    var fetchMoviesCalled: Bool = false
    func fetchMovies(completion: @escaping (Result<[Movie], MoviesError>) -> ()) {
        if fetchMoviesCalled == true {
            completion(.success([Movie.movieStub()]))
        } else  {
            completion(.failure(MoviesError.noData))
        }
        return
    }
}

