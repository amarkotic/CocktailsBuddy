import Combine
import Foundation
import Dependencies

class FilterViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var filters: FiltersModel = .empty
    @Published var appliedFilters: AppliedFiltersModel = .empty
    @Published var filteredCocktails: [CocktailSearchCardModel] = []

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
            .receive(on: DispatchQueue.main)
            .catch { _ in Just(.empty) }
            .assign(to: &$filters)
    }

    func search(completion: @escaping () -> Void) {
        useCase
            .applyFilter(model: appliedFilters)
            .receive(on: DispatchQueue.main)
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
