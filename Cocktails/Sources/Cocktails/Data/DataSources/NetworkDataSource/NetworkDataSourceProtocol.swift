import Combine

protocol NetworkDataSourceProtocol {

    func fetchCocktailDetails(id: String?) -> AnyPublisher<CocktailNetworkDSModel, Error>

    func searchCocktails(_ query: String) -> AnyPublisher<CocktailsSearchNetworkDSModel, Error>

    func fetchFilters(for type: FilterType) -> AnyPublisher<FiltersNetworkDSModel, Error>

    func applyFilter(model: AppliedFiltersNetworkDSModel) -> AnyPublisher<CocktailsSearchNetworkDSModel, Error>

}
