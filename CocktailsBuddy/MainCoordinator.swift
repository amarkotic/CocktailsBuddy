import UIKit
import Cocktails
import CoreUI

class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.isHidden = true
    }

    func start() {
        configureCocktailsCoordinator()
    }

    private func configureCocktailsCoordinator() {
        let cocktailsCoordinator = CocktailsCoordinator(navigationController: navigationController)
        childCoordinators.append(cocktailsCoordinator)
        cocktailsCoordinator.start()
    }

}
