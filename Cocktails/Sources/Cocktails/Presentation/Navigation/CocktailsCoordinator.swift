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
        let viewModel = DetailsViewModel(coordinator: self, id: cocktailID)
        let detailsView = DetailsView(viewModel: viewModel)
        pushHostingViewController(with: detailsView)
    }

    func showFilters() {
        let viewModel = FilterViewModel(coordinator: self)
        let filtersView = FilterView(viewModel: viewModel)
        pushHostingViewController(with: filtersView)
    }

    func showFilterResults(appliedFilters: AppliedFiltersModel) {
        let viewModel = FilteredCocktailsViewModel(coordinator: self, appliedFilters: appliedFilters)
        let resultsView = FilteredCocktailsView(viewModel: viewModel)
        pushHostingViewController(with: resultsView)
    }

}
