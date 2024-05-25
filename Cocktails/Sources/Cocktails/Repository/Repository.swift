import Combine
import Dependencies

class Repository: RepositoryProtocol, DependencyKey {

    static var liveValue: any RepositoryProtocol = Repository()

    @Dependency(\.dataSource) private var dataSource: DataSourceProtocol

    func getDetails(id: String?) -> AnyPublisher<DetailsRepositoryModel, Error> {
        dataSource
            .getDetails(id: id)
            .map { DetailsRepositoryModel(from: $0) }
            .eraseToAnyPublisher()
    }

    func searchCocktails(query: String) -> AnyPublisher<[CocktailRepositoryModel], Error> {
        dataSource
            .searchCocktails(query: query)
            .map { $0.map { CocktailRepositoryModel(from: $0) } }
            .eraseToAnyPublisher()
    }

}

extension DependencyValues {

    var repository: RepositoryProtocol {
        get { self[Repository.self] }
        set { self[Repository.self] = newValue }
    }

}
