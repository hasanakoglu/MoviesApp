import Foundation
import UIKit

protocol Coordinator {
    func start()
    func didSelect(movie: Movie?)
}

protocol Router: AnyObject {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
}

extension UINavigationController: Router { }
