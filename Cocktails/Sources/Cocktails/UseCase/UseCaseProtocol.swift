import Combine

protocol UseCaseProtocol {

    func getDetails(id: String?) -> AnyPublisher<DetailsModel, Error>

    func searchCocktails(query: String) -> AnyPublisher<[CocktailCardModel], Never>

}
