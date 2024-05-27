import Combine
import Foundation
import Dependencies

class CocktailsListViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var items: [CocktailSearchCardModel] = []
    @Published var query: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        bindSearch()
    }

    func bindSearch() {
        $query
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .flatMap { self.useCase.searchCocktails(query: $0) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cocktails in
                self?.items = cocktails.sorted { $0.title < $1.title }
            }
            .store(in: &cancellables)
    }

}
