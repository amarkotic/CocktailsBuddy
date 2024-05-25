import Combine

protocol DataSourceProtocol {

    func getDetails(id: String) -> AnyPublisher<DetailsDataSourceModel, Error>

    func searchCocktails(query: String) -> AnyPublisher<[CocktailDataSourceModel], Error>

}
