import Combine
import Foundation
import Dependencies
import Core

class FiltersViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var filters: Result<FiltersModel> = .loading
    @Published var appliedFilters: AppliedFiltersModel = .empty

    private let coordinator: CocktailsCoordinator
    private var cancellables = Set<AnyCancellable>()

    var anyFilterSelected: Bool {
        appliedFilters.alcohol != nil ||
        appliedFilters.glass != nil ||
        appliedFilters.category != nil
    }

    init(coordinator: CocktailsCoordinator) {
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
