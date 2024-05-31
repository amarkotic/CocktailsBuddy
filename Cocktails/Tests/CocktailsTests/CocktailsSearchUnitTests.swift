import XCTest
import Combine
import Dependencies
@testable import Cocktails

final class CocktailsSearchViewModelTests: XCTestCase {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol
    var viewModel: CocktailsSearchViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = CocktailsSearchViewModel(coordinator: CocktailsCoordinatorMock())
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testQueryChangesTriggerSearch() {
        let expectation = expectation(description: "Query changes trigger search")

        viewModel.query = "Margarita"

        viewModel
            .$items
            .dropFirst()
            .sink { result in
                switch result {
                case .success(let cocktails):
                    XCTAssertTrue(cocktails.count > 0)
                    expectation.fulfill()
                case .failure:
                    XCTFail("Expected success, got \(result) instead")
                case .loading:
                    break
                }
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

    func testSelectCocktail() {
        let coordinator = CocktailsCoordinatorMock()
        viewModel = CocktailsSearchViewModel(coordinator: coordinator)
        viewModel.selectCocktail("11007")
        XCTAssertTrue(coordinator.showCocktailDetailsCalled)
    }

    func testOpenFilters() {
        let coordinator = CocktailsCoordinatorMock()
        viewModel = CocktailsSearchViewModel(coordinator: coordinator)
        viewModel.openFilters()
        XCTAssertTrue(coordinator.showFiltersCalled)
    }

}
