import Combine

class Repository: RepositoryProtocol {

    private let dataSource: DataSourceProtocol

    init(dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
    }

    func getDetails(id: String) -> AnyPublisher<DetailsRepositoryModel, Error> {
        dataSource
            .getDetails(id: id)
            .map { _ in DetailsRepositoryModel() }
            .eraseToAnyPublisher()
    }

}
