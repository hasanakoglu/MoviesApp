import Foundation

protocol FavouritesManagerProtocol {
    func addToFavourites(for object: [Movie])
    func removeFromFavourites(movie: Movie)
    func retrieveFavourites() -> [Movie]
}

class FavouritesManager: FavouritesManagerProtocol {
    let userDefaults: UserDefaultsProtocol
    private let key = "Fav"
    private let decoder = JSONDecoder()
    
    init(userDefaults: UserDefaultsProtocol = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func addToFavourites(for object: [Movie]) {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(object) else { return }
        userDefaults.set(encoded, forKey: key)
    }
    
    func removeFromFavourites(movie: Movie) {
        guard let data = userDefaults.value(forKey: key) as? Data else { return }
        guard var favourites = try? decoder.decode([Movie].self, from: data) else { return }
        favourites.removeAll(where: { $0.title == movie.title })
        
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(favourites) else { return }
        userDefaults.set(encoded, forKey: key)
    }
    
    func retrieveFavourites() -> [Movie] {
        guard let data = userDefaults.value(forKey: key) as? Data else { return [] }
        guard let favourites = try? decoder.decode([Movie].self, from: data) else { return [] }
        return favourites
    }
}
