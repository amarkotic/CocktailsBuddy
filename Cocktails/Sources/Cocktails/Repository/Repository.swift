import Combine
import Dependencies

class Repository: RepositoryProtocol, DependencyKey {

    static var liveValue: any RepositoryProtocol = Repository()

    @Dependency(\.networkDataSource) private var networkDataSource: NetworkDataSourceProtocol

    func getDetails(id: String?) -> AnyPublisher<DetailsRepositoryModel, Error> {
        networkDataSource
            .fetchDetails(id: id)
            .map { DetailsRepositoryModel(from: DetailsDataSourceModel(from: $0.firstDrink)) }
            .eraseToAnyPublisher()
    }

    func searchCocktails(query: String) -> AnyPublisher<[CocktailRepositoryModel], Error> {
        networkDataSource
            .searchCocktails(query)
            .map { $0.drinks.map { CocktailRepositoryModel(from: CocktailDataSourceModel(from: $0)) } }
            .eraseToAnyPublisher()
    }

    func getFilter(for type: FilterType) -> AnyPublisher<FilterRepositoryModel, Error> {
        networkDataSource
            .fetchFilter(for: type)
            .map { FilterRepositoryModel(from: $0) }
            .eraseToAnyPublisher()
    }

}

extension DependencyValues {

    var repository: RepositoryProtocol {
        get { self[Repository.self] }
        set { self[Repository.self] = newValue }
    }

}
