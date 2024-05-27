import Combine
import Dependencies

class Repository: RepositoryProtocol, DependencyKey {

    static var liveValue: any RepositoryProtocol = Repository()

    @Dependency(\.networkDataSource) private var networkDataSource: NetworkDataSourceProtocol

    func getDetails(id: String?) -> AnyPublisher<CocktailRepositoryModel, Error> {
        networkDataSource
            .fetchCocktailDetails(id: id)
            .map { CocktailRepositoryModel(from: $0) }
            .eraseToAnyPublisher()
    }

    func searchCocktails(query: String) -> AnyPublisher<[CocktailSearchRepositoryModel], Error> {
        networkDataSource
            .searchCocktails(query)
            .map { $0.drinks.map { CocktailSearchRepositoryModel(from: $0) } }
            .eraseToAnyPublisher()
    }

    func getFilter(for type: FilterType) -> AnyPublisher<FilterRepositoryModel, Error> {
        networkDataSource
            .fetchFilters(for: type)
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
