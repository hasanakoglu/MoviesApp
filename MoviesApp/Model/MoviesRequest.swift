import Foundation

enum MoviesError: Error {
    case noData
    case jsonError
}

protocol MoviesRequestProtocol {
    func fetchMovies(completion: @escaping(Result<[Movie], MoviesError>) -> Void)
}

class MoviesRequest: MoviesRequestProtocol {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchMovies(completion: @escaping (Result<[Movie], MoviesError>) -> ()) {
        let urlString = API.moviesURL
        guard let url = URL(string: urlString) else { return }
        session.dataTask(with: url) { (data, response, error) in
            guard let jsonData = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MoviesResponseModel.self, from: jsonData)
                let movies = response.movies
                completion(.success(movies))
            } catch {
                completion(.failure(.jsonError))
            }
        }.resume()
    }
}

enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}

extension Result {
    var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}
