import Foundation
import UIKit

final class FavouritesCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let viewModel = FavouritesViewModel()
        let favouritesViewController = FavouritesViewController(viewModel: viewModel)
        favouritesViewController.coordinator = self
        router.pushViewController(favouritesViewController, animated: true)
    }
    
    func didSelect(movie: Movie?) {
        guard let movie = movie else { return }
        let viewModel = MovieDetailsViewModel()
        let detailsViewController = MovieDetailsViewController(movie: movie, viewModel: viewModel)
        router.pushViewController(detailsViewController, animated: true)
    }
}
