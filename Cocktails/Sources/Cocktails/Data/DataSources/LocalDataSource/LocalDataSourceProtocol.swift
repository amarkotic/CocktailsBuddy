import Combine

public protocol LocalDataSourceProtocol {

    func getCocktailDetails(id: String?) -> AnyPublisher<CocktailLocalDSModel, Error>

    func getCocktail(id: String?) -> CocktailLocalDSModel?

    func saveCocktail(model: CocktailLocalDSModel)

}
