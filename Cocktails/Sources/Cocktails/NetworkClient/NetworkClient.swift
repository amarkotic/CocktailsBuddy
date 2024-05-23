import Combine
import Foundation
import Networking

class NetworkClient: NetworkClientProtocol {

    private let baseApiClient: BaseApiClientProtocol

    private init(baseApiClient: BaseApiClientProtocol) {
        self.baseApiClient = baseApiClient
    }

    func fetchDetails(id: String) -> AnyPublisher<DetailsNetworkModel, Error> {
        baseApiClient
            .performRequest(
                Endpoint.details(id).generatePath(),
                method: .get,
                body: nil,
                responseType: DetailsNetworkModel.self)
            .mapError { _ in NetworkError() }
            .eraseToAnyPublisher()
    }

}
