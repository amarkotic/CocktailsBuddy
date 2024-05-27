import Combine

protocol RepositoryProtocol {

    func getDetails(id: String?) -> AnyPublisher<CocktailRepositoryModel, Error>

    func searchCocktails(query: String) -> AnyPublisher<[CocktailSearchRepositoryModel], Error>

    func getFilter(for type: FilterType) -> AnyPublisher<FilterRepositoryModel, Error>

}
