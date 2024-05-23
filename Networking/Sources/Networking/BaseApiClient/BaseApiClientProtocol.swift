import Combine
import Foundation

public protocol BaseApiClientProtocol {

    func performRequest<T: Decodable>(
        _ url: String,
        method: HTTPMethod,
        body: Data?,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError>

}
