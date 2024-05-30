import SwiftUI
import UIKit
import Core
import CoreUI

public class CocktailsCoordinator: Coordinator {

    public var navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        showSearchScreen()
    }

    func showSearchScreen() {
        let viewModel = CocktailsSearchViewModel(coordinator: self)
        let searchView = CocktailsSearchView(viewModel: viewModel)
        pushHostingViewController(with: searchView)
    }

    func showCocktailDetails(for cocktailID: String?) {
        let viewModel = CocktailDetailsViewModel(coordinator: self, id: cocktailID)
        let detailsView = CocktailDetailsView(viewModel: viewModel)
        pushHostingViewController(with: detailsView)
    }

    func showFilters() {
        let viewModel = FiltersViewModel(coordinator: self)
        let filtersView = FiltersView(viewModel: viewModel)
        pushHostingViewController(with: filtersView)
    }

    func showFilterResults(appliedFilters: AppliedFiltersModel) {
        let viewModel = FilteredCocktailsViewModel(coordinator: self, appliedFilters: appliedFilters)
        let resultsView = FilteredCocktailsView(viewModel: viewModel)
        pushHostingViewController(with: resultsView)
    }

}

extension CocktailsCoordinator {

    static var mock: CocktailsCoordinator {
        CocktailsCoordinator(navigationController: UINavigationController())
    }

}
