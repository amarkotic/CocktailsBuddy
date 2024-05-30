import Combine
import Foundation
import SwiftUI
import Dependencies
import Core

class CocktailsSearchViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var items: Result<[CocktailSearchCardModel]> = .loading
    @Published var query: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        bindSearch()
    }

    func bindSearch() {
        $query
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .flatMap { [weak self] query -> AnyPublisher<Result<[CocktailSearchCardModel]>, Never> in
                guard let self else { return .empty() }

                return self.useCase.getCocktails(query: query)
            }
            .receiveOnMain()
            .assign(to: &$items)
    }

}
