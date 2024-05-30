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

extension Publisher where Output: Equatable {

    // Map a chain which can fail to a nonfailable chain which transfers failure inside a Result type
    public func mapToNonFailingResult() -> AnyPublisher<Result<Output>, Never> {
        map { Result.success($0) }
            .catch { _ in Just(Result.failure) }
            .eraseToAnyPublisher()
    }

}
