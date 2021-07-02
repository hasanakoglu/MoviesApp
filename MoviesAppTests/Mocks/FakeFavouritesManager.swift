import Foundation

@testable import MoviesApp

class FakeFavouritesManager: FavouritesManagerProtocol {
    var addToFavouritesCalled = false
    func addToFavourites(for object: [Movie]) {
        addToFavouritesCalled = true
    }
    
    var removeFromFavouritesCalled = false
    func removeFromFavourites(movie: Movie) {
        removeFromFavouritesCalled = true
    }
    
    var retrieveFavouritesCalled = false
    func retrieveFavourites() -> [Movie] {
        retrieveFavouritesCalled = true
        return []
    }
}

