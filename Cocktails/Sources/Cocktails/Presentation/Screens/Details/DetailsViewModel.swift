import Combine
import Foundation
import Dependencies
import Core

class DetailsViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var details: Result<CocktailModel> = .loading
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    init(id: String?) {
        fetchDetails(id: id)
    }

    func fetchDetails(id: String?) {
        useCase
            .getDetails(id: id)
            .receiveOnMain()
            .assign(to: &$details)
    }

}
