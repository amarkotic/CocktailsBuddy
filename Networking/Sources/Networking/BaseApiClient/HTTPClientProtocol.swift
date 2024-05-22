import Foundation
import Combine

protocol HTTPClientProtocol {

    func publisher(request: URLRequest) -> AnyPublisher<HTTPResponse, Error>

}
