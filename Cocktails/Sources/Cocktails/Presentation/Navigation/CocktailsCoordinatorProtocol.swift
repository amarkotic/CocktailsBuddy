import CoreUI

protocol CocktailsCoordinatorProtocol: Coordinator {

    func showSearchScreen()

    func showCocktailDetails(for cocktailID: String?)

    func showFilters()

    func showFilterResults(appliedFilters: AppliedFiltersModel)

}
