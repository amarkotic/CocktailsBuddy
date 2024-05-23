import Combine
import Foundation

public class DetailsViewModel: ObservableObject {

    @Published var details: DetailsModel?
    @Published var errorMessage: String?

    private let useCase: UseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init(useCase: UseCaseProtocol) {
        self.useCase = useCase
    }

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
