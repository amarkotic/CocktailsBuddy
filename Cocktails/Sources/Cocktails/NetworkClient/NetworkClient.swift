import Foundation
import Combine
import Dependencies
import Networking

class NetworkClient: NetworkClientProtocol, DependencyKey {

    static var liveValue: any NetworkClientProtocol = NetworkClient()

    @Dependency(\.baseApiClient) private var baseApiClient: BaseApiClientProtocol

    func fetchDetails(id: String) -> AnyPublisher<DrinksNetworkModel, Error> {
        baseApiClient
            .performRequest(
                Endpoint.details(id).urlString,
                method: .get,
                body: nil,
                responseType: DrinksNetworkModel.self)
            .mapError { _ in NetworkError() }
            .eraseToAnyPublisher()
    }

    func searchCocktails(_ query: String) -> AnyPublisher<DrinksNetworkModel, Error> {
        baseApiClient
            .performRequest(
                Endpoint.search(query).urlString,
                method: .get,
                body: nil,
                responseType: DrinksNetworkModel.self)
            .mapError { _ in NetworkError() }
            .eraseToAnyPublisher()
    }

}

extension DependencyValues {

    var networkClient: NetworkClientProtocol {
        get { self[NetworkClient.self] }
        set { self[NetworkClient.self] = newValue }
    }

}
