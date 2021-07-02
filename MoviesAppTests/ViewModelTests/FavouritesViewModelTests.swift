import Foundation
import XCTest

@testable import MoviesApp

class FavouritesViewModelTests: XCTestCase {
    var subject: FavouritesViewModel!
    var fakeFavouritesManager: FakeFavouritesManager!
    let character = MarvelCharacter.characterStub()

    override func setUp() {
        super.setUp()
        fakeFavouritesManager = FakeFavouritesManager()
        subject = FavouritesViewModel(favouritesManager: fakeFavouritesManager)
    }

    override func tearDown() {
        subject = nil
    }
    
    func testViewWillAppear() {
        subject.viewWillAppear()
        XCTAssertTrue(fakeFavouritesManager.retrieveFavouritesCalled)
    }
}
