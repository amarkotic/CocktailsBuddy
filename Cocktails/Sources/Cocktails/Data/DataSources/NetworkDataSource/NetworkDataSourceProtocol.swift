import Combine

protocol NetworkDataSourceProtocol {

    func getCocktailDetails(id: String?) -> AnyPublisher<CocktailNetworkDSModel, Error>

    func getCocktails(_ query: String) -> AnyPublisher<CocktailsSearchNetworkDSModel, Error>

    func getFilter(for type: FilterType) -> AnyPublisher<FiltersNetworkDSModel, Error>

    func getFilteredCocktails(model: AppliedFiltersNetworkDSModel) -> AnyPublisher<CocktailsSearchNetworkDSModel, Error>

}
