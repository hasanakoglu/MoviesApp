import Foundation
import XCTest

@testable import MoviesApp

final class AppTabBarControllerTests: XCTestCase {
    var mockCoordinatorFactory: MockCoordinatorFactory!
    var subject: MainTabBarController!
    
    override func setUp() {
        super.setUp()
        mockCoordinatorFactory = MockCoordinatorFactory()
        subject = MainTabBarController(coordinatorFactory: mockCoordinatorFactory)
    }
    
    override func tearDown() {
        mockCoordinatorFactory = nil
        subject = nil
        super.tearDown()
    }
    
    func testMainViewCoordinator() {
        let mainViewCoordinator = subject.coordinators.compactMap { $0 as? MockMainCoordinator }.first
        XCTAssertNotNil(mainViewCoordinator)
        XCTAssertTrue(mainViewCoordinator?.startCalled == true)
        XCTAssertTrue(subject.viewControllers?.first === mockCoordinatorFactory.mainRouter)
    }
    
    func testFavouritesCoordinator() {
        let favouriteCoordinator = subject.coordinators.compactMap { $0 as? MockFavouriteCoordinator }.first
        XCTAssertNotNil(favouriteCoordinator)
        XCTAssertTrue(favouriteCoordinator?.startCalled == true)
        XCTAssertTrue(subject.viewControllers?.last === mockCoordinatorFactory.favouriteRouter)
    }
}

final class MockCoordinatorFactory: CoordinatorFactoryProtocol {
    var mainRouter: Router?
    func makeMainViewCoordinator(router: Router) -> Coordinator {
        mainRouter = router
        return MockMainCoordinator()
    }
    
    var favouriteRouter: Router?
    func makeFavouritesCoordinator(router: Router) -> Coordinator {
        favouriteRouter = router
        return MockFavouriteCoordinator()
    }
}

class MockCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var startCalled: Bool = false
    func start() {
        startCalled = true
    }
    
    var didSelectCalled: Bool = false
    func didSelect(movie: Movie?) {
        didSelectCalled = true
    }
}

final class MockMainCoordinator: MockCoordinator { }
final class MockFavouriteCoordinator: MockCoordinator { }
