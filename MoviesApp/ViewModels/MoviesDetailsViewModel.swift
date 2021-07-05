import Foundation

protocol MovieDetailsViewModelProtocol {
    var favourites: [Movie] { get }
    func viewWillAppear()
    func buttonSelectedState(movie: Movie) -> Bool
    func addToFavourites(movie: Movie)
    func removeFromFavourites(movie: Movie)
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    let favouritesManager: FavouritesManagerProtocol
    var favourites = [Movie]()
    
    init(favouritesManager: FavouritesManagerProtocol = FavouritesManager()) {
        self.favouritesManager = favouritesManager
    }
    
    func viewWillAppear() {
        favourites = favouritesManager.retrieveFavourites()
    }
    
    func buttonSelectedState(movie: Movie) -> Bool {
        if favourites.contains(where: { $0.title == movie.title }) {
            return true
        } else {
            return false
        }
    }
    
    func addToFavourites(movie: Movie) {
        if !favourites.contains(where: { $0.title == movie.title }) {
            favourites.append(movie)
        }
        favouritesManager.addToFavourites(for: favourites)
    }
    
    func removeFromFavourites(movie: Movie) {
        favouritesManager.removeFromFavourites(movie: movie)
    }
}
