import Foundation
import XCTest

@testable import MoviesApp

class FavouritesManagerTests: XCTestCase {
    private var mockDefaults: MockDefaults!
    private var subject: FavouritesManager!
    
    override func setUp() {
        super.setUp()
        mockDefaults = MockDefaults()
        subject = FavouritesManager(userDefaults: mockDefaults)
    }
    
    override func tearDown() {
        mockDefaults = nil
        subject = nil
        super.tearDown()
    }
    
    func testAddToFavourites() throws {
        let movie = Movie.movieStub()
        subject.addToFavourites(for: [movie])
        let favourites = try JSONDecoder().decode([Movie].self, from: mockDefaults.setValue as! Data)
        XCTAssertEqual(favourites, [movie])
    }
    
    func testRemoveFromFavourites() throws {
        let movies = [Movie.movieStub()]
        let encodedmovies = try JSONEncoder().encode(movies)
        mockDefaults.value = encodedmovies
        
        let movie = movies[0]
        subject.removeFromFavourites(movie: movie)
        let favourites = try JSONDecoder().decode([Movie].self, from: mockDefaults.setValue as! Data)
        XCTAssertFalse(favourites.contains(movie))
    }
    
    func testRetrieveFavourites() throws {
        let movies = [Movie.movieStub()]
        let encodedmovies = try JSONEncoder().encode(movies)
        mockDefaults.value = encodedmovies
        
        let favourites = try JSONDecoder().decode([Movie].self, from: mockDefaults.value as! Data)
        let savedFavourites = subject.retrieveFavourites()
        XCTAssertEqual(savedFavourites, favourites)
    }
    
    func testRetrieveFavouritesReturnsEmpty() {
        let savedFavourites = subject.retrieveFavourites()
        XCTAssertEqual(savedFavourites, [])
    }
}

