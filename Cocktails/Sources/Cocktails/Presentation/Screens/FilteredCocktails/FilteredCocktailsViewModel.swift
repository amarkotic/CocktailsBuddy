import Combine
import Foundation
import Dependencies
import Core

class FilteredCocktailsViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var filteredCocktails: Result<[CocktailCardModel]> = .loading

    private let coordinator: CocktailsCoordinator
    private var cancellables = Set<AnyCancellable>()

    init(coordinator: CocktailsCoordinator, appliedFilters: AppliedFiltersModel) {
        self.coordinator = coordinator
        bindViews(model: appliedFilters)
    }

    func bindViews(model: AppliedFiltersModel) {
        useCase
            .getFilteredCocktails(model: model)
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
