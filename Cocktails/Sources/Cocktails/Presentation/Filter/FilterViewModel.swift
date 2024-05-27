import Combine
import Foundation
import Dependencies

class FilterViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var selectedCategory: String?
    @Published var selectedGlass: String?
    @Published var selectedAlcohol: String?

    @Published public var filterModel: CocktailFilterModel = .empty

    private var cancellables = Set<AnyCancellable>()

    func fetchFilters() {
        useCase
            .allFilters
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { filterModel in
                    self.filterModel = filterModel
                })
            .store(in: &cancellables)
    }

}
