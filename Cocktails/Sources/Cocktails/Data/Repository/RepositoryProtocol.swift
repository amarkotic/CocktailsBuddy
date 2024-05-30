import Combine

protocol RepositoryProtocol {

    func getCocktailDetails(id: String?) -> AnyPublisher<CocktailRepositoryModel, Error>

    func getCocktails(query: String) -> AnyPublisher<[CocktailSearchRepositoryModel], Error>

    func getFilter(for type: FilterType) -> AnyPublisher<FilterRepositoryModel, Error>

    func getFilteredCocktails(
        model: AppliedFiltersRepositoryModel
    ) -> AnyPublisher<[CocktailSearchRepositoryModel], Error>

}
