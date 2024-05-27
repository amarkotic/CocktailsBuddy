import Foundation
import Combine
import Core
import Dependencies

class BaseApiClient: BaseApiClientProtocol, DependencyKey {

    public static var liveValue: any BaseApiClientProtocol = BaseApiClient()

    private let httpClient: HTTPClientProtocol = URLSession.shared

    func performRequest<T: Decodable>(
        _ url: URL?,
        method: HTTPMethod,
        body: Data? = nil,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError> {
        Future<URLRequest, NetworkError> { promise in
            guard let url = url else {
                return promise(.failure(.invalidUrl))
            }

            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.httpBody = body
            promise(.success(request))
        }
        .flatMap { request in
            self.httpClient
                .publisher(request: request)
                .map { $0.data }
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { error in
                    Core.Logger.shared.log(error: error)

                    switch error {
                    case is URLError:
                        return .networkError(error)
                    case is DecodingError:
                        return .decodingError(error)
                    default:
                        return .invalidResponse
                    }
                }
        }
        .eraseToAnyPublisher()
    }

}

public extension DependencyValues {

    var baseApiClient: BaseApiClientProtocol {
        get { self[BaseApiClient.self] }
        set { self[BaseApiClient.self] = newValue }
    }

}
