import Foundation

@testable import MoviesApp

class FakeFavouritesViewModel: FavouritesViewModelProtocol {
    var favourites: [Movie] = []
        
    func viewWillAppear() {
    }
    
    var addToFavouritesCalled = false
    func addToFavourites(movie: Movie) {
        addToFavouritesCalled = true
    }
    
    func removeFromFavourites(movie: Movie) {
    }
}

