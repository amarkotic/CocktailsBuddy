import Foundation
import Combine
import Core

class BaseApiClient {

    public static let shared = BaseApiClient()

    private let httpClient: HTTPClientProtocol

    private init(httpClient: HTTPClientProtocol = URLSession.shared) {
        self.httpClient = httpClient
    }

    func performRequest<T: Decodable>(
        _ url: String,
        method: HTTPMethod,
        body: Data? = nil,
        responseType: T.Type
    ) throws -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: url) else { throw NetworkError.invalidUrl }

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
