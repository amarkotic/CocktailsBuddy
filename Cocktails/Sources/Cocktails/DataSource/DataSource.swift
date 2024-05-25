import Combine
import Dependencies

class DataSource: DataSourceProtocol, DependencyKey {

    static var liveValue: any DataSourceProtocol = DataSource()

    @Dependency(\.networkClient) private var networkClient: NetworkClientProtocol

    func getDetails(id: String) -> AnyPublisher<DetailsDataSourceModel, Error> {
        networkClient
            .fetchDetails(id: id)
            .map { DetailsDataSourceModel(from: $0.firstDrink) }
            .eraseToAnyPublisher()
    }

    func searchCocktails(query: String) -> AnyPublisher<[CocktailDataSourceModel], Error> {
        networkClient
            .searchCocktails(query)
            .map { $0.drinks.map { CocktailDataSourceModel(from: $0) } }
            .eraseToAnyPublisher()
    }

}

extension DependencyValues {

    var dataSource: DataSourceProtocol {
        get { self[DataSource.self] }
        set { self[DataSource.self] = newValue }
    }

}
