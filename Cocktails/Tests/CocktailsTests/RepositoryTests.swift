import XCTest
import Combine
import Dependencies
@testable import Cocktails

final class RepositoryTests: XCTestCase {

    @Dependency(\.repository) private var repository: RepositoryProtocol

    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    func testGetCocktailDetails() {
        let expectation = expectation(description: "Retrieve cocktail details")

        repository
            .getCocktailDetails(id: "11007")
            .sinkToExpectation(expectation) { result in
                XCTAssertEqual(result.name, "Margarita")
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

    func testGetCocktailList() {
        let expectation = expectation(description: "Retrieve cocktail list")

        repository
            .getCocktails(query: "")
            .sinkToExpectation(expectation) { result in
                XCTAssertGreaterThan(result.count, 0)
                XCTAssertNotNil(result.first?.name)
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

    func testSearchCocktailsByName() {
        let expectation = expectation(description: "Search cocktails by name")

        repository
            .getCocktails(query: "Margarita")
            .sinkToExpectation(expectation) { result in
                XCTAssertGreaterThan(result.count, 0)
                XCTAssertEqual(result.first?.name, "Margarita")
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

    func testGetCocktailDetailsError() {
        let expectation = expectation(description: "Handle error for invalid cocktail ID")

        repository
            .getCocktailDetails(id: "invalid_id")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but received value")
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

}
