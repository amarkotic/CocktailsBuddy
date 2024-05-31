import XCTest
import Combine
import Dependencies
@testable import Cocktails

final class CocktailDetailsViewModelTests: XCTestCase {

    var viewModel: CocktailDetailsViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = CocktailDetailsViewModel(coordinator: CocktailsCoordinatorMock(), id: nil)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchDetails() {
        let expectation = expectation(description: "Fetch details")

        viewModel
            .$details
            .dropFirst()
            .sink { result in
                switch result {
                case .success(let cocktail):
                    XCTAssertNotNil(cocktail)
                    expectation.fulfill()
                case .loading, .failure:
                    XCTFail("Expected to fetch details successfully")
                }
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

}
