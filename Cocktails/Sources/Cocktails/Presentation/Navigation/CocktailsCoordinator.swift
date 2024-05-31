import SwiftUI
import UIKit
import Core
import CoreUI

public class CocktailsCoordinator: CocktailsCoordinatorProtocol {

    public var navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        showSearchScreen()
    }

    public func showSearchScreen() {
        guard navigationController.viewControllers.count == 0 else { return }

        let viewModel = CocktailsSearchViewModel(coordinator: self)
        let searchView = CocktailsSearchView(viewModel: viewModel)
        pushHostingViewController(with: searchView)
    }

    public func showCocktailDetails(for cocktailID: String?) {
        let viewModel = CocktailDetailsViewModel(coordinator: self, id: cocktailID)
        let detailsView = CocktailDetailsView(viewModel: viewModel)
        pushHostingViewController(with: detailsView)
    }

    public func showFilters() {
        let viewModel = FiltersViewModel(coordinator: self)
        let filtersView = FiltersView(viewModel: viewModel)
        pushHostingViewController(with: filtersView)
    }

    public func showFilterResults(appliedFilters: AppliedFiltersModel) {
        let viewModel = FilteredCocktailsViewModel(coordinator: self, appliedFilters: appliedFilters)
        let resultsView = FilteredCocktailsView(viewModel: viewModel)
        pushHostingViewController(with: resultsView)
    }

}
