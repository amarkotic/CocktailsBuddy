import Combine
import Dependencies

class UseCase: UseCaseProtocol, DependencyKey {

    static var liveValue: any UseCaseProtocol = UseCase()

    @Dependency(\.repository) private var repository: RepositoryProtocol

    func getDetails(id: String) -> AnyPublisher<DetailsModel, Error> {
        repository
            .getDetails(id: id)
            .map { DetailsModel(from: $0) }
            .eraseToAnyPublisher()
    }

}

extension DependencyValues {

    var useCase: UseCaseProtocol {
        get { self[UseCase.self] }
        set { self[UseCase.self] = newValue }
    }

}
