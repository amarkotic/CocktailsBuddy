import Foundation
import Combine

extension URLSession: HTTPClientProtocol {

    struct HTTPResponseError: Error {}

    func publisher(request: URLRequest) -> AnyPublisher<HTTPResponse, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.serverError(statusCode: httpResponse.statusCode)
                }

                return HTTPResponse(data: output.data, urlResponse: httpResponse)
            }
            .eraseToAnyPublisher()
    }

}
