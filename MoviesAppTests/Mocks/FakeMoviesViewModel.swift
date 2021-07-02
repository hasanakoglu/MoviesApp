import Foundation
import UIKit

@testable import MoviesApp

class FakeMoviesViewModel: MoviesViewModelProtocol {
    var listOfMovies: [Movie] = [Movie.movieStub()]
    
    var movieImages: [String : UIImage] = [:]
    
    var fetchMoviesCalled: Bool = false
    func fetchMovies(completion: @escaping () -> ()) {
        fetchMoviesCalled = true
        return
    }
}

