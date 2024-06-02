import XCTest
import Combine
import Dependencies
import Networking
@testable import Cocktails

final class NetworkDataSourceTests: XCTestCase {

    @Dependency(\.networkDataSource) private var networkDataSource: NetworkDataSourceProtocol

    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    func testGetCocktailDetailsSuccess() {
        let expectation = expectation(description: "Fetch cocktail details")

        networkDataSource
            .getCocktailDetails(id: "11007")
            .sinkToExpectation(expectation) { result in
                XCTAssertEqual(result.id, "11007")
                XCTAssertEqual(result.name, "Margarita")
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

    func testGetCocktailsSuccess() {
        let expectation = expectation(description: "Search cocktails")

        networkDataSource
            .getCocktails("Margarita")
            .sinkToExpectation(expectation) { result in
                guard let drinks = result.drinks else {
                    XCTFail("No drinks found")
                    return
                }
                XCTAssertTrue(drinks.contains { $0.name == "Margarita" })
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

    func testGetFilterSuccess() {
        let expectation = expectation(description: "Fetch filters")

        networkDataSource
            .getFilter(for: .alcohol)
            .sinkToExpectation(expectation) { result in
                guard let filters = result.filters else {
                    XCTFail("No filters found")
                    return
                }
                XCTAssertTrue(filters.contains { $0.name == "Alcoholic" })
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

    func testGetFilteredCocktailsSuccess() {
        let expectation = expectation(description: "Fetch filtered cocktails")
        let appliedFiltersModel = AppliedFiltersNetworkDSModel(alcohol: "Alcoholic", category: nil, glass: nil)

        networkDataSource
            .getFilteredCocktails(model: appliedFiltersModel)
            .sinkToExpectation(expectation) { result in
                guard let drinks = result.drinks else {
                    XCTFail("No drinks found")
                    return
                }
                XCTAssertTrue(drinks.count > 0)
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

    func testGetRandomCocktailDetails() {
        let expectation = expectation(description: "Fetch random cocktail details")

        networkDataSource
            .getCocktailDetails(id: nil)
            .sinkToExpectation(expectation) { result in
                XCTAssertNotNil(result)
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

}
