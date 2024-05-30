import Combine
import Foundation
import Dependencies
import Core

class DetailsViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var details: Result<CocktailModel> = .loading
    @Published var errorMessage: String?

    private let coordinator: CocktailsCoordinator

    init(coordinator: CocktailsCoordinator, id: String?) {
        self.coordinator = coordinator
        fetchDetails(id: id)
    }

    func fetchDetails(id: String?) {
        useCase
            .getCocktailDetails(id: id)
            .receiveOnMain()
            .assign(to: &$details)
    }

}

// MARK: - Coordinator methods
extension DetailsViewModel {

    func backTap() {
        coordinator.popViewController()
    }

}
