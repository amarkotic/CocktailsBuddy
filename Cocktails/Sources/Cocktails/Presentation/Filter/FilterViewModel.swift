import Combine
import Foundation
import Dependencies

class FilterViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var selectedCategory: String?
    @Published var selectedGlass: String?
    @Published var selectedAlcohol: String?

    @Published public var filtersModel: FiltersModel = .empty

    private var cancellables = Set<AnyCancellable>()

    func fetchFilters() {
        useCase
            .allFilters
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { filtersModel in
                    self.filtersModel = filtersModel
                })
            .store(in: &cancellables)
    }

}
