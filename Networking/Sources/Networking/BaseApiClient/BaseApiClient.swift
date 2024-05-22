import Foundation
import Combine
import Core

class BaseAPIClient {

    public static let shared = BaseAPIClient()

    private let httpClient: HTTPClientProtocol

    private init(httpClient: HTTPClientProtocol = URLSession.shared) {
        self.httpClient = httpClient
    }

    func performRequest<T: Decodable>(
        _ url: URL,
        method: HTTPMethod,
        body: Data? = nil,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError> {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body

        return httpClient
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
