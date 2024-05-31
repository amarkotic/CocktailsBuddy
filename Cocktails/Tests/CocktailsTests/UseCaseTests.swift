import XCTest
import Combine
import Dependencies
@testable import Cocktails

final class UseCaseTests: XCTestCase {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

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

        useCase
            .getCocktailDetails(id: "11007")
            .sinkToExpectation(expectation) { result in
                switch result {
                case .success(let cocktail):
                    XCTAssertEqual(cocktail.name, "Margarita")
                case .failure, .loading:
                    XCTFail("Expected success, got \(result) instead")
                }
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

    func testGetCocktails() {
        let expectation = expectation(description: "Retrieve cocktail list")

        useCase
            .getCocktails(query: "Margarita")
            .sinkToExpectation(expectation) { result in
                switch result {
                case .success(let cocktails):
                    XCTAssertGreaterThan(cocktails.count, 0)
                    XCTAssertNotNil(cocktails.first?.title)
                    XCTAssertEqual(cocktails.last?.isLastItem, true)
                case .failure, .loading:
                    XCTFail("Expected success, got \(result) instead")
                }
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

    func testAllFilters() {
        let expectation = expectation(description: "Retrieve all filters")

        useCase
            .allFilters
            .sinkToExpectation(expectation) { result in
                switch result {
                case .success(let filters):
                    XCTAssertNotNil(filters)
                    XCTAssertGreaterThan(filters.alcoholicFilterItems.count, 0)
                    XCTAssertGreaterThan(filters.glassFilterItems.count, 0)
                    XCTAssertGreaterThan(filters.categoryFilterItems.count, 0)
                case .failure, .loading:
                    XCTFail("Expected success, got \(result) instead")
                }
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

    func testGetFilteredCocktails() {
        let expectation = expectation(description: "Retrieve filtered cocktails")

        let filters = AppliedFiltersModel(
            alcohol: "Alcoholic",
            category: "Cocktail",
            glass: "Cocktail glass"
        )

        useCase
            .getFilteredCocktails(model: filters)
            .sinkToExpectation(expectation) { result in
                switch result {
                case .success(let cocktails):
                    XCTAssertGreaterThan(cocktails.count, 0)
                    XCTAssertNotNil(cocktails.first?.title)
                    XCTAssertEqual(cocktails.last?.isLastItem, true)
                case .failure, .loading:
                    XCTFail("Expected success, got \(result) instead")
                }
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

}
