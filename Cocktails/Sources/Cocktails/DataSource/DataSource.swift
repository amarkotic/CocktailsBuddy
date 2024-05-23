import Combine

class DataSource: DataSourceProtocol {

    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func getDetails(id: String) -> AnyPublisher<DetailsDataSourceModel, Error> {
        networkClient
            .fetchDetails(id: id)
            .map { DetailsDataSourceModel(from: $0) }
            .eraseToAnyPublisher()
    }

}
