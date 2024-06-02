import XCTest
import Combine
@testable import Networking

final class NetworkingTests: XCTestCase {

    var apiClient: BaseApiClient!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        apiClient = BaseApiClient()
        cancellables = []
    }

    override func tearDown() {
        apiClient = nil
        cancellables = nil
        super.tearDown()
    }

    func testPerformRequestWithValidURL() {
        let expectation = self.expectation(description: "Valid URL request should succeed")
        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/random.php")

        apiClient
            .performRequest(url, method: .get, responseType: CocktailResponse.self)
            .sinkToExpectation(expectation) { result in
                XCTAssertNotNil(result)
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)

    }

    func testPerformRequestWithInvalidURL() {
        let expectation = self.expectation(description: "Invalid URL request should fail")
        let url: URL? = nil

        apiClient
            .performRequest(url, method: .get, responseType: CocktailResponse.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertFalse(error.localizedDescription.isEmpty)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Request should not succeed")
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

    func testPerformRequestWithNetworkError() {
        let expectation = self.expectation(description: "Request with network error should fail")
        let url = URL(string: "https://www.invalidurl.com")

        apiClient
            .performRequest(url, method: .get, responseType: CocktailResponse.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertFalse(error.errorDescription.isEmpty)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Request should not succeed")
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

}

// Helper models
extension NetworkingTests {

    struct CocktailResponse: Decodable {

        let drinks: [Drink]

    }

    struct Drink: Decodable {

        let idDrink: String
        let strDrink: String
        let strCategory: String?

    }

}
