import Combine
import Foundation
import Dependencies
import Core

class FilteredCocktailsViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var filteredCocktails: Result<[CocktailCardModel]> = .loading

    private let appliedFilters: AppliedFiltersModel
    private let coordinator: CocktailsCoordinatorProtocol

    init(coordinator: CocktailsCoordinatorProtocol, appliedFilters: AppliedFiltersModel) {
        self.coordinator = coordinator
        self.appliedFilters = appliedFilters

        bindViews()
    }

    func bindViews() {
        useCase
            .getFilteredCocktails(model: appliedFilters)
            .receiveOnMain()
            .assign(to: &$filteredCocktails)
    }

}

// MARK: - Coordinator methods
extension FilteredCocktailsViewModel {

    func selectCocktail(_ cocktailID: String?) {
        coordinator.showCocktailDetails(for: cocktailID)
    }

    func backTap() {
        coordinator.popToRoot()
    }

}
