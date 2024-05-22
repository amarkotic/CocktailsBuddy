import Combine

class UseCase: UseCaseProtocol {

    private let repository: RepositoryProtocol

    init(repository: RepositoryProtocol) {
        self.repository = repository
    }

    func getDetails(id: String) -> AnyPublisher<DetailsModel, Error> {
        repository
            .getDetails(id: id)
            .map { DetailsModel(from: $0) }
            .eraseToAnyPublisher()
    }

}
