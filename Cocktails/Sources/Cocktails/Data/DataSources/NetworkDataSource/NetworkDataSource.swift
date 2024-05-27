import Combine
import Foundation
import Dependencies
import Networking

class NetworkDataSource: NetworkDataSourceProtocol, DependencyKey {

    static var liveValue: any NetworkDataSourceProtocol = NetworkDataSource()

    @Dependency(\.baseApiClient) private var baseApiClient: BaseApiClientProtocol

    func fetchCocktailDetails(id: String?) -> AnyPublisher<CocktailResponse, Error> {
        let url: URL?
        if let id {
            url = Endpoint.details(id: id).url
        } else {
            url = Endpoint.randomDetails.url
        }

        return baseApiClient
            .performRequest(url, method: .get, body: nil, responseType: CocktailsResponse.self)
            .compactMap { $0.firstDrink }
            .mapError { _ in NetworkError() }
            .eraseToAnyPublisher()
    }

    func searchCocktails(_ query: String) -> AnyPublisher<CocktailsSearchResponse, Error> {
        let url = Endpoint.search(query: query).url

        return baseApiClient
            .performRequest(url, method: .get, body: nil, responseType: CocktailsSearchResponse.self)
            .mapError { _ in NetworkError() }
            .eraseToAnyPublisher()
    }

    func fetchFilters(for type: FilterType) -> AnyPublisher<FiltersResponse, Error> {
        let url = Endpoint.filter(type: type).url

        return baseApiClient
            .performRequest(url, method: .get, body: nil, responseType: FiltersResponse.self)
            .mapError { _ in NetworkError() }
            .eraseToAnyPublisher()
    }

    func applyFilter(model: AppliedFiltersNetworkDataSourceModel) -> AnyPublisher<CocktailsSearchResponse, Error> {
        let url = Endpoint.applyFilter(model: model).url

        return baseApiClient
            .performRequest(url, method: .get, body: nil, responseType: CocktailsSearchResponse.self)
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
