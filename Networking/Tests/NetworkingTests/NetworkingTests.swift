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
        var result: CocktailResponse?

        apiClient
            .performRequest(url, method: .get, responseType: CocktailResponse.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Request failed with error: \(error)")
                }
            }, receiveValue: { value in
                result = value
                expectation.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
        XCTAssertNotNil(result)
    }

    func testPerformRequestWithInvalidURL() {
        let expectation = self.expectation(description: "Invalid URL request should fail")
        let url: URL? = nil

        apiClient
            .performRequest(url, method: .get, responseType: CocktailResponse.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertTrue(error.errorDescription.contains("Invalid url"))
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
                    XCTAssertTrue(error.errorDescription.contains("Network error"))
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Request should not succeed")
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

    func testPerformPostRequest() {
        let expectation = self.expectation(description: "POST request should succeed")
        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/random.php")
        let body = try? JSONSerialization.data(withJSONObject: ["key": "value"], options: [])

        apiClient
            .performRequest(url, method: .post, body: body, responseType: CocktailResponse.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Request failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { _ in
                expectation.fulfill()
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
