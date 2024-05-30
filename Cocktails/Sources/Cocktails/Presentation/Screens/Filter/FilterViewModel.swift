import Combine
import Foundation
import Dependencies
import Core

class FilterViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var filters: Result<FiltersModel> = .loading
    @Published var appliedFilters: AppliedFiltersModel = .empty
    @Published var filteredCocktails: Result<[CocktailSearchCardModel]> = .loading

    private var cancellables = Set<AnyCancellable>()

    var anyFilterSelected: Bool {
        appliedFilters.alcohol != nil ||
        appliedFilters.glass != nil ||
        appliedFilters.category != nil
    }

    init() {
        bindViews()
    }

    func bindViews() {
        useCase
            .allFilters
            .receiveOnMain()
            .assign(to: &$filters)
    }

    func search(completion: @escaping () -> Void) {
        useCase
            .getFilteredCocktails(model: appliedFilters)
            .receiveOnMain()
            .sink { [weak self] results in
                self?.filteredCocktails = results
                completion()
            }
            .store(in: &cancellables)
    }

    func resetFilters() {
        appliedFilters.reset()
    }

}
