import Foundation

enum CharacterError: Error {
    case noData
    case jsonError
}

protocol CharacterRequestProtocol {
    func fetchCharacters(completion: @escaping(Result<[Movie], CharacterError>) -> Void)
}

class CharacterRequest: CharacterRequestProtocol {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchCharacters(completion: @escaping (Result<[Movie], CharacterError>) -> ()) {
        let urlString = API.charactersURL
        guard let url = URL(string: urlString) else { return }
        session.dataTask(with: url) { (data, response, error) in
            guard let jsonData = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MoviesResponseModel.self, from: jsonData)
                let characters = response.movies
                completion(.success(characters))
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
