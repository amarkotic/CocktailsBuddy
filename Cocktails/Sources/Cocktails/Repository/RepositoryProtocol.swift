import Combine

protocol RepositoryProtocol {

    func getDetails(id: String) -> AnyPublisher<DetailsRepositoryModel, Error>

    func searchCocktails(query: String) -> AnyPublisher<[CocktailRepositoryModel], Error>

}
