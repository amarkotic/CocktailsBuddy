import Combine
import Foundation
import Dependencies
import Networking

class NetworkDataSource: NetworkDataSourceProtocol, DependencyKey {

    static var liveValue: any NetworkDataSourceProtocol = NetworkDataSource()

    @Dependency(\.baseApiClient) private var baseApiClient: BaseApiClientProtocol

    func fetchDetails(id: String?) -> AnyPublisher<DrinksNetworkModel, Error> {
        let url: URL?
        if let id {
            url = Endpoint.details(id: id).url
        } else {
            url = Endpoint.randomDetails.url
        }

        return baseApiClient
            .performRequest(url, method: .get, body: nil, responseType: DrinksNetworkModel.self)
            .mapError { _ in NetworkError() }
            .eraseToAnyPublisher()
    }

    func searchCocktails(_ query: String) -> AnyPublisher<DrinksNetworkModel, Error> {
        let url = Endpoint.search(query: query).url

        return baseApiClient
            .performRequest(url, method: .get, body: nil, responseType: DrinksNetworkModel.self)
            .mapError { _ in NetworkError() }
            .eraseToAnyPublisher()
    }

    func fetchFilter(for type: FilterType) -> AnyPublisher<FilterResponse, Error> {
        let url = Endpoint.filter(type: type).url

        return baseApiClient
            .performRequest(url, method: .get, body: nil, responseType: FilterResponse.self)
            .mapError { _ in NetworkError() }
            .eraseToAnyPublisher()
    }

}

extension DependencyValues {

    var networkDataSource: NetworkDataSourceProtocol {
        get { self[NetworkDataSource.self] }
        set { self[NetworkDataSource.self] = newValue }
    }

}
