import Combine
import Foundation
import Dependencies
import Core

class CocktailDetailsViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var details: Result<CocktailModel> = .loading

    private let coordinator: CocktailsCoordinatorProtocol

    init(coordinator: CocktailsCoordinatorProtocol, id: String?) {
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
extension CocktailDetailsViewModel {

    func backTap() {
        coordinator.popViewController()
    }

}
