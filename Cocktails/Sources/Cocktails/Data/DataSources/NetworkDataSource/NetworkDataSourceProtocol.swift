import Combine

protocol NetworkDataSourceProtocol {

    func fetchCocktailDetails(id: String?) -> AnyPublisher<CocktailResponse, Error>

    func searchCocktails(_ query: String) -> AnyPublisher<CocktailsSearchResponse, Error>

    func fetchFilters(for type: FilterType) -> AnyPublisher<FiltersResponse, Error>

    func applyFilter(model: AppliedFiltersNetworkDataSourceModel) -> AnyPublisher<CocktailsSearchResponse, Error>

}
