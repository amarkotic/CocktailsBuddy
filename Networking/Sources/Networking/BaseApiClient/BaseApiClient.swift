import Combine
import Foundation
import Dependencies
import Core

class BaseApiClient: BaseApiClientProtocol, DependencyKey {

    public static let liveValue: any BaseApiClientProtocol = BaseApiClient()
    public static let testValue: any BaseApiClientProtocol = BaseApiClient()

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
        .flatMap { [weak self] request -> AnyPublisher<T, NetworkError> in
            guard let self else { return .empty() }

            return self.executeAndReturn(request: request)
        }
        .eraseToAnyPublisher()
    }

}

private extension BaseApiClient {

    func executeAndReturn<T: Decodable>(request: URLRequest) -> AnyPublisher<T, NetworkError> {
        httpClient
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
            .eraseToAnyPublisher()
    }

}

public extension DependencyValues {

    var baseApiClient: BaseApiClientProtocol {
        get { self[BaseApiClient.self] }
        set { self[BaseApiClient.self] = newValue }
    }

}
