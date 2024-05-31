import XCTest
import Combine
import Dependencies
@testable import Cocktails

final class FiltersViewModelTests: XCTestCase {

    var viewModel: FiltersViewModel!

    override func setUp() {
        super.setUp()
        viewModel = FiltersViewModel(coordinator: CocktailsCoordinatorMock())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testApplyFilter() {
        let expectedAlcoholFilter = "Vodka"
        viewModel.appliedFilters.alcohol = expectedAlcoholFilter
        XCTAssertEqual(viewModel.appliedFilters.alcohol, expectedAlcoholFilter, "Filter should be applied correctly.")
    }

    func testResetFilters() {
        viewModel.appliedFilters.alcohol = "Vodka"
        viewModel.appliedFilters.glass = "Highball glass"
        viewModel.appliedFilters.category = "Cocktail"

        viewModel.resetFilters()

        XCTAssertNil(viewModel.appliedFilters.alcohol, "The alcohol filter should be reset to nil.")
        XCTAssertNil(viewModel.appliedFilters.glass, "The glass filter should be reset to nil.")
        XCTAssertNil(viewModel.appliedFilters.category, "The category filter should be reset to nil.")
    }

    func testOpenFilteredResults() {
        let coordinator = CocktailsCoordinatorMock()
        viewModel = FiltersViewModel(coordinator: coordinator)
        viewModel.showFilteredResults()
        XCTAssertTrue(coordinator.showFilteredResultsCalled)
    }

}
