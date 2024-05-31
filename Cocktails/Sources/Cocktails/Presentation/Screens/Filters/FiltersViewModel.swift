import Combine
import Foundation
import Dependencies
import Core

class FiltersViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var filters: Result<FiltersModel> = .loading
    @Published var appliedFilters: AppliedFiltersModel = .empty

    var anyFilterSelected: Bool {
        appliedFilters.alcohol != nil ||
        appliedFilters.glass != nil ||
        appliedFilters.category != nil
    }

    private let coordinator: CocktailsCoordinatorProtocol

    init(coordinator: CocktailsCoordinatorProtocol) {
        self.coordinator = coordinator

        bindViews()
    }

    func bindViews() {
        useCase
            .allFilters
            .receiveOnMain()
            .assign(to: &$filters)
    }

    func resetFilters() {
        appliedFilters.reset()
    }

}

// MARK: - Coordinator methods
extension FiltersViewModel {

    func showFilteredResults() {
        coordinator.showFilterResults(appliedFilters: appliedFilters)
    }

    func backTap() {
        coordinator.popViewController()
    }

}
