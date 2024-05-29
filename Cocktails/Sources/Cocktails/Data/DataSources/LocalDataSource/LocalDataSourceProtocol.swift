import Combine

protocol LocalDataSourceProtocol {

    func getCocktailDetails(id: String?) -> AnyPublisher<CocktailLocalDSModel, Error>

    func saveCocktail(model: CocktailLocalDSModel)

}
