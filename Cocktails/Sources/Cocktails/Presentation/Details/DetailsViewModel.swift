import Combine
import Foundation
import Dependencies

class DetailsViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    @Published var details: DetailsModel?
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    func fetchDetails(id: String) {
        useCase
            .getDetails(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { details in
                self.details = details
            })
            .store(in: &cancellables)
    }

}
