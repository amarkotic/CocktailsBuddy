import Combine

protocol UseCaseProtocol {

    func getDetails(id: String?) -> AnyPublisher<CocktailModel, Error>

    func searchCocktails(query: String) -> AnyPublisher<[CocktailSearchCardModel], Never>

    var allFilters: AnyPublisher<FiltersModel, Error> { get }

    func applyFilter(model: AppliedFiltersModel) -> AnyPublisher<[CocktailSearchCardModel], Never>

}
