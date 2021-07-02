import Foundation

protocol FavouritesManagerProtocol {
    func addToFavourites(for object: [MarvelCharacter])
    func removeFromFavourites(character: MarvelCharacter)
    func retrieveFavourites() -> [MarvelCharacter]
}

class FavouritesManager: FavouritesManagerProtocol {
    let userDefaults: UserDefaultsProtocol
    private let key = "Fav"
    private let decoder = JSONDecoder()
    
    init(userDefaults: UserDefaultsProtocol = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func addToFavourites(for object: [MarvelCharacter]) {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(object) else { return }
        userDefaults.set(encoded, forKey: key)
    }
    
    func removeFromFavourites(character: MarvelCharacter) {
        guard let data = userDefaults.value(forKey: key) as? Data else { return }
        guard var favourites = try? decoder.decode([MarvelCharacter].self, from: data) else { return }
        favourites.removeAll(where: { $0.name == character.name })
        
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(favourites) else { return }
        userDefaults.set(encoded, forKey: key)
    }
    
    func retrieveFavourites() -> [MarvelCharacter] {
        guard let data = userDefaults.value(forKey: key) as? Data else { return [] }
        guard let favourites = try? decoder.decode([MarvelCharacter].self, from: data) else { return [] }
        return favourites
    }
}
