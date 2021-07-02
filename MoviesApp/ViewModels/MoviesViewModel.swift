import Foundation
import UIKit

protocol CharactersViewModelProtocol {
    var listOfCharacters: [Movie] { get set }
    var characterImages: [String: UIImage] { get set }
    func fetchCharacters(completion: @escaping () -> ())
}

class CharactersViewModel: CharactersViewModelProtocol {
    var listOfCharacters = [Movie]()
    var characterImages = [String: UIImage]()
    let request: MoviesRequestProtocol
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared, request: MoviesRequestProtocol) {
        self.urlSession = urlSession
        self.request = request
    }
    
    func fetchCharacters(completion: @escaping () -> ()) {
        request.fetchMovies { result in
            switch result {
            
            case .success(let characters):
                self.listOfCharacters = characters
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
}
