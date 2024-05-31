import SwiftUI
import UIKit
import Core
import CoreUI

// Mock for previews and tests
class CocktailsCoordinatorMock: CocktailsCoordinatorProtocol {

    var showSearchScreenCalled = false
    var showCocktailDetailsCalled = false
    var showFiltersCalled = false
    var showFilteredResultsCalled = false

    var navigationController = UINavigationController()

    func start() {}

    func showSearchScreen() {
        showSearchScreenCalled = true
    }

    func showCocktailDetails(for cocktailID: String?) {
        showCocktailDetailsCalled = true
    }

    func showFilters() {
        showFiltersCalled = true
    }

    func showFilterResults(appliedFilters: AppliedFiltersModel) {
        showFilteredResultsCalled = true
    }

}
