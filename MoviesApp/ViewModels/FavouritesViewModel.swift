import Foundation

protocol FavouritesViewModelProtocol {
    var favourites: [Movie] { get set }
    func viewWillAppear()
}

class FavouritesViewModel: FavouritesViewModelProtocol {
    var favourites = [Movie]()
    var favouritesManager: FavouritesManagerProtocol
    
    init(favouritesManager: FavouritesManagerProtocol = FavouritesManager()) {
        self.favouritesManager = favouritesManager
    }
    
    func viewWillAppear() {
        favourites = favouritesManager.retrieveFavourites()
    }
}
