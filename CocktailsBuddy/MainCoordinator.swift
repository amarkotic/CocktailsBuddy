import UIKit
import Cocktails
import CoreUI

// Parent coordinator designed to store different coordinators from feature modules and handle navigation between them
class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.isHidden = true
    }

    func start() {
        let coordinator = configureCocktailsCoordinator()
        coordinator.start()
    }

    func deepLinkToCocktailDetails(for id: String?) {
        let coordinator = childCoordinators
            .compactMap { $0 as? CocktailsCoordinator }
            .first ?? configureCocktailsCoordinator()
        coordinator.start()
        coordinator.showCocktailDetails(for: id)
    }

    private func configureCocktailsCoordinator() -> CocktailsCoordinatorProtocol {
        let cocktailsCoordinator = CocktailsCoordinator(navigationController: navigationController)
        childCoordinators.append(cocktailsCoordinator)

        return cocktailsCoordinator
    }

}
