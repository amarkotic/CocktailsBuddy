import Combine
import Dependencies

class Repository: RepositoryProtocol, DependencyKey {

    static var liveValue: any RepositoryProtocol = Repository()

    @Dependency(\.networkDataSource) private var networkDataSource: NetworkDataSourceProtocol
    @Dependency(\.localDataSource) private var localDataSource: LocalDataSourceProtocol

    // Try retrieving cocktail details from local data source, and if that fails - fetch it from the network
    func getDetails(id: String?) -> AnyPublisher<CocktailRepositoryModel, Error> {
        fetchFromLocalDataSource(id: id)
            .catch { _ in self.fetchFromNetworkDataSource(id: id) }
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

    func applyFilter(model: AppliedFiltersRepositoryModel) -> AnyPublisher<[CocktailSearchRepositoryModel], Error> {
        networkDataSource
            .applyFilter(model: model.toModel())
            .map { $0.drinks.map { CocktailSearchRepositoryModel(from: $0) } }
            .eraseToAnyPublisher()
    }

}

extension Repository {

    fileprivate func fetchFromLocalDataSource(id: String?) -> AnyPublisher<CocktailRepositoryModel, Error> {
        localDataSource
            .getCocktailDetails(id: id)
            .map { CocktailRepositoryModel(from: $0) }
            .eraseToAnyPublisher()
    }

    fileprivate func fetchFromNetworkDataSource(id: String?) -> AnyPublisher<CocktailRepositoryModel, Error> {
        networkDataSource
            .fetchCocktailDetails(id: id)
            .handleEvents(receiveOutput: { [weak self] cocktailResponse in
                self?.saveToLocalDataSource(cocktailResponse)
            })
            .map { CocktailRepositoryModel(from: $0) }
            .eraseToAnyPublisher()
    }

    fileprivate func saveToLocalDataSource(_ cocktailResponse: CocktailNetworkDSModel) {
        let localModel = CocktailLocalDSModel(from: cocktailResponse)
        localDataSource.saveCocktail(model: localModel)
    }

}

extension DependencyValues {

    var repository: RepositoryProtocol {
        get { self[Repository.self] }
        set { self[Repository.self] = newValue }
    }

}
