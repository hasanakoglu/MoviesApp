import Foundation

protocol CoordinatorFactoryProtocol {
    func makeMainViewCoordinator(router: Router) -> Coordinator
    func makeFavouritesCoordinator(router: Router) -> Coordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeMainViewCoordinator(router: Router) -> Coordinator {
        MainViewCoordinator(router: router)
    }
    
    func makeFavouritesCoordinator(router: Router) -> Coordinator {
        FavouritesCoordinator(router: router)
    }
}
