import Foundation

protocol CharacterDetailsViewModelProtocol {
    var favourites: [Movie] { get set }
    func viewWillAppear()
    func buttonSelectedState(character: Movie) -> Bool
    func addToFavourites(character: Movie)
    func removeFromFavourites(character: Movie)
}

class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    let favouritesManager: FavouritesManagerProtocol
    var favourites = [Movie]()
    
    init(favouritesManager: FavouritesManagerProtocol = FavouritesManager()) {
        self.favouritesManager = favouritesManager
    }
    
    func viewWillAppear() {
        favourites = favouritesManager.retrieveFavourites()
    }
    
    func buttonSelectedState(character: Movie) -> Bool {
        if favourites.contains(where: { $0.title == character.title }) {
            return true
        } else {
            return false
        }
    }
    
    func addToFavourites(character: Movie) {
        if !favourites.contains(where: { $0.title == character.title }) {
            favourites.append(character)
        }
        favouritesManager.addToFavourites(for: favourites)
    }
    
    func removeFromFavourites(character: Movie) {
        favouritesManager.removeFromFavourites(character: character)
    }
}
