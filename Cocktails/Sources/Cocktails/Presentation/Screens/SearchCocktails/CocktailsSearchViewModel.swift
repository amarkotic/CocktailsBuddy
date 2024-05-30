import Combine
import Foundation
import SwiftUI
import Dependencies
import Core

class CocktailsSearchViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var items: Result<[CocktailCardModel]> = .loading
    @Published var query: String = ""

    private let coordinator: CocktailsCoordinator

    init(coordinator: CocktailsCoordinator) {
        self.coordinator = coordinator
        bindSearch()
    }

    func bindSearch() {
        $query
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .flatMap { [weak self] query -> AnyPublisher<Result<[CocktailCardModel]>, Never> in
                guard let self else { return .empty() }

                return self.useCase.getCocktails(query: query)
            }
            .receiveOnMain()
            .assign(to: &$items)
    }

}

// MARK: - Coordinator methods
extension CocktailsSearchViewModel {

    func selectCocktail(_ cocktailID: String?) {
        coordinator.showCocktailDetails(for: cocktailID)
    }

    func openFilters() {
        coordinator.showFilters()
    }

}
