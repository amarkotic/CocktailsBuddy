import Combine
import Foundation
import Dependencies
import Core

class CocktailDetailsViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var details: Result<CocktailModel> = .loading

    private let id: String?
    private let coordinator: CocktailsCoordinatorProtocol

    init(coordinator: CocktailsCoordinatorProtocol, id: String?) {
        self.coordinator = coordinator
        self.id = id

        bindViews()
    }

    func bindViews() {
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
