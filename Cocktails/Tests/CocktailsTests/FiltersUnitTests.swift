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
        viewModel.alcohol = expectedAlcoholFilter
        XCTAssertEqual(viewModel.alcohol, expectedAlcoholFilter, "Filter should be applied correctly.")
        XCTAssertEqual(viewModel.anyFilterSelected, true, "Filter is selected, but the anyFilterSelected is false")
    }

    func testResetFilters() {
        viewModel.alcohol = "Vodka"
        viewModel.glass = "Highball glass"
        viewModel.category = "Cocktail"

        viewModel.resetFilters()

        XCTAssertNil(viewModel.alcohol, "The alcohol filter should be reset to nil.")
        XCTAssertNil(viewModel.glass, "The glass filter should be reset to nil.")
        XCTAssertNil(viewModel.category, "The category filter should be reset to nil.")
        XCTAssertFalse(viewModel.anyFilterSelected, "No filter should be selected after reset")
    }

    func testOpenFilteredResults() {
        let coordinator = CocktailsCoordinatorMock()
        viewModel = FiltersViewModel(coordinator: coordinator)
        viewModel.showFilteredResults()
        XCTAssertTrue(coordinator.showFilteredResultsCalled)
    }

}
