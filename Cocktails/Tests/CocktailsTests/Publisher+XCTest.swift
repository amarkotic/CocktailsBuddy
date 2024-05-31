import Combine
import XCTest

extension Publisher where Failure: Error {

    func sinkToExpectation(
        _ expectation: XCTestExpectation,
        file: StaticString = #file,
        line: UInt = #line,
        receiveValue: @escaping ((Output) -> Void)
    ) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            if case .failure(let error) = completion {
                XCTFail("Request failed with error: \(error)", file: file, line: line)
            }
            expectation.fulfill()
        },
             receiveValue: receiveValue
        )
    }

}
