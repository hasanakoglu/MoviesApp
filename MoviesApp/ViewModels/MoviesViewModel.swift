import Foundation
import UIKit

protocol MoviesViewModelProtocol {
    var listOfMovies: [Movie] { get } 
    func fetchMovies(completion: @escaping () -> ())
}

class MoviesViewModel: MoviesViewModelProtocol {
    var listOfMovies = [Movie]()
    var movieImages = [String: UIImage]()
    let request: MoviesRequestProtocol
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared, request: MoviesRequestProtocol) {
        self.urlSession = urlSession
        self.request = request
    }
    
    func fetchMovies(completion: @escaping () -> ()) {
        request.fetchMovies { result in
            switch result {
            
            case .success(let movies):
                self.listOfMovies = movies
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
