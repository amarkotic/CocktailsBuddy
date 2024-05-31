import Combine

public protocol LocalDataSourceProtocol {

    func getCocktail(id: String?) -> CocktailLocalDSModel?

    func saveCocktail(model: CocktailLocalDSModel)

}
