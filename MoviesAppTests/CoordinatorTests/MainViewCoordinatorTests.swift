import XCTest

@testable import MoviesApp

class MainViewCoordinatorTests: XCTestCase {
    var subject: MainViewCoordinator!
    var navigationController: UINavigationController!

    override func setUp() {
        navigationController = UINavigationController()
        subject = MainViewCoordinator(router: navigationController)
    }

    override func tearDown() {
        subject = nil
    }

    func testStart() {
        subject.start()
        let mainVC = navigationController.topViewController as? MainViewController
        XCTAssertNotNil(mainVC)
    }
    
    func testDidSelectMovie() {
        let mockMovie = Movie(title: "name", year: "2021", rate: 2.0, posterImage: "", overview: "")
        subject.didSelect(movie: mockMovie)
        let movieDetailsVC = navigationController.topViewController as? MovieDetailsViewController
        XCTAssertNotNil(movieDetailsVC)
    }
    
    
    func testDidSelectWithNoMovie() {
        subject.didSelect(movie: nil)
        let correctViewController = navigationController.topViewController as? MovieDetailsViewController
        XCTAssertNil(correctViewController)
    }
}
