import Combine

protocol DataSourceProtocol {

    func getDetails(id: String) -> AnyPublisher<DetailsDataSourceModel, Error>

}
