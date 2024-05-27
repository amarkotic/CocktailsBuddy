import Combine
import Foundation
import SwiftUI
import Dependencies

class CocktailsSearchViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var items: [CocktailSearchCardModel] = []
    @Published var query: String = ""

    private var cancellables = Set<AnyCancellable>()

    init(items: [CocktailSearchCardModel]? = nil) {
        if let items {
            self.items = items
        }

        bindSearch()
    }

    func bindSearch() {
        $query
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .flatMap { self.useCase.searchCocktails(query: $0) }
            .map { $0.sorted { $0.title < $1.title } }
            .receive(on: DispatchQueue.main)
            .assign(to: &$items)
    }

}
