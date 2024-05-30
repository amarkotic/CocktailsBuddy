import Combine
import Foundation
import Dependencies
import Networking

class NetworkDataSource: NetworkDataSourceProtocol, DependencyKey {

    static var liveValue: any NetworkDataSourceProtocol = NetworkDataSource()

    @Dependency(\.baseApiClient) private var baseApiClient: BaseApiClientProtocol

    func fetchCocktailDetails(id: String?) -> AnyPublisher<CocktailNetworkDSModel, Error> {
        let url: URL?
        if let id {
            url = Endpoint.details(id: id).url
        } else {
            url = Endpoint.randomDetails.url
        }

        return baseApiClient
            .performRequest(url, method: .get, body: nil, responseType: CocktailsNetworkDSModel.self)
            .compactMap { $0.firstDrink }
            .mapError { NetworkError(from: $0) }
            .eraseToAnyPublisher()
    }

    func searchCocktails(_ query: String) -> AnyPublisher<CocktailsSearchNetworkDSModel, Error> {
        let url = Endpoint.search(query: query).url

        return baseApiClient
            .performRequest(url, method: .get, body: nil, responseType: CocktailsSearchNetworkDSModel.self)
            .mapError { NetworkError(from: $0) }
            .eraseToAnyPublisher()
    }

    func fetchFilters(for type: FilterType) -> AnyPublisher<FiltersNetworkDSModel, Error> {
        let url = Endpoint.filter(type: type).url

        return baseApiClient
            .performRequest(url, method: .get, body: nil, responseType: FiltersNetworkDSModel.self)
            .mapError { NetworkError(from: $0) }
            .eraseToAnyPublisher()
    }

    func applyFilter(model: AppliedFiltersNetworkDSModel) -> AnyPublisher<CocktailsSearchNetworkDSModel, Error> {
        let url = Endpoint.applyFilter(model: model).url

        return baseApiClient
            .performRequest(url, method: .get, body: nil, responseType: CocktailsSearchNetworkDSModel.self)
            .mapError { NetworkError(from: $0) }
            .eraseToAnyPublisher()
    }

}

extension DependencyValues {

    var networkDataSource: NetworkDataSourceProtocol {
        get { self[NetworkDataSource.self] }
        set { self[NetworkDataSource.self] = newValue }
    }

}
