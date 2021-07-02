import Foundation

@testable import MoviesApp

class FakeMovieDetailsViewModel: MovieDetailsViewModelProtocol {
    var favourites: [Movie] = []
        
    func viewWillAppear() {
    }
    
    var addToFavouritesCalled = false
    func addToFavourites(movie: Movie) {
        addToFavouritesCalled = true
    }
    
    func removeFromFavourites(movie: Movie) {
    }
    
    func buttonSelectedState(movie: Movie) -> Bool {
        true
    }
}

