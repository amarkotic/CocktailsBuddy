import Combine
import Foundation
import Dependencies
import Core

class FiltersViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var filters: Result<FiltersModel> = .loading
    @Published var alcohol: String?
    @Published var category: String?
    @Published var glass: String?
    @Published var anyFilterSelected: Bool = false

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

        Publishers.CombineLatest3($alcohol, $category, $glass)
            .map { alcohol, category, glass in
                return alcohol != nil || category != nil || glass != nil
            }
            .assign(to: &$anyFilterSelected)
    }

    func resetFilters() {
        alcohol = nil
        category = nil
        glass = nil
    }

}

// MARK: - Coordinator methods
extension FiltersViewModel {

    func showFilteredResults() {
        let appliedFilters = AppliedFiltersModel(alcohol: alcohol, category: category, glass: glass)
        coordinator.showFilterResults(appliedFilters: appliedFilters)
    }

    func backTap() {
        coordinator.popViewController()
    }

}
