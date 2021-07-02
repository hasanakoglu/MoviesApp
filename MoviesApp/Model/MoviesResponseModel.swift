import Foundation

struct MoviesResponseModel: Codable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Codable, Equatable {
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
    }
}

extension Movie {
    var fullImageString: String {
        guard let posterImageString = posterImage else { return "" }
        return "https://image.tmdb.org/t/p/w300" + posterImageString
    }
}
