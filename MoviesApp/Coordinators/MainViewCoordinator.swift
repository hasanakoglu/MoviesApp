import Foundation
import UIKit

final class MainViewCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let viewModel = MoviesViewModel(request: MoviesRequest())
        let mainViewController = MainViewController(viewModel: viewModel)
        mainViewController.coordinator = self
        router.pushViewController(mainViewController, animated: true)
    }
    
    func didSelect(movie: Movie?) {
        guard let movie = movie else { return }
        let viewModel = MovieDetailsViewModel()
        let detailsViewController = MovieDetailsViewController(movie: movie, viewModel: viewModel)
        router.pushViewController(detailsViewController, animated: true)
    }
}
