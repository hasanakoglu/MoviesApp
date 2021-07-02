import Foundation
import XCTest

@testable import MoviesApp

class MovieDetailsViewModelTests: XCTestCase {
    var subject: MovieDetailsViewModel!
    var fakeFavouritesManager: FakeFavouritesManager!
    let movie = Movie.movieStub()

    override func setUp() {
        super.setUp()
        fakeFavouritesManager = FakeFavouritesManager()
        subject = MovieDetailsViewModel(favouritesManager: fakeFavouritesManager)
    }

    override func tearDown() {
        subject = nil
    }
    
    func testViewWillAppear() {
        subject.viewWillAppear()
        XCTAssertTrue(fakeFavouritesManager.retrieveFavouritesCalled)
    }
    
    func testAddToFavourites() {
        subject.addToFavourites(movie: movie)
        XCTAssertTrue(fakeFavouritesManager.addToFavouritesCalled)
    }
    
    func testRemoveFromFavourites() {
        subject.removeFromFavourites(movie: movie)
        XCTAssertTrue(fakeFavouritesManager.removeFromFavouritesCalled)
    }
    
    func testButtonSelectedStateTrue() {
        subject.favourites.append(movie)
        XCTAssertEqual(subject.buttonSelectedState(movie: movie), true)
    }
    
    func testButtonSelectedStateFalse() {
        XCTAssertEqual(subject.buttonSelectedState(movie: movie), false)
    }
}
