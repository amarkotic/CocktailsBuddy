import Combine
import Foundation

extension Publisher {

    public static func empty() -> AnyPublisher<Output, Failure> {
        Empty<Output, Failure>().eraseToAnyPublisher()
    }

    public static func never() -> AnyPublisher<Output, Failure> {
        Empty<Output, Failure>(completeImmediately: false).eraseToAnyPublisher()
    }

    public func receiveOnMain() -> AnyPublisher<Output, Failure> {
        receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}
