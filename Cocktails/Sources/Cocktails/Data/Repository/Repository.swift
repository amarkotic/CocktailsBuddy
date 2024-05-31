import Combine
import Dependencies

class Repository: RepositoryProtocol, DependencyKey {

    static var liveValue: any RepositoryProtocol = Repository()
    static var testValue: any RepositoryProtocol = Repository()

    @Dependency(\.networkDataSource) private var networkDataSource: NetworkDataSourceProtocol
    @Dependency(\.localDataSource) private var localDataSource: LocalDataSourceProtocol

    // Try retrieving cocktail details from local data source, and if that fails - fetch it from the network
    func getCocktailDetails(id: String?) -> AnyPublisher<CocktailRepositoryModel, Error> {
        fetchFromLocalDataSource(id: id)
            .catch { [weak self] _ -> AnyPublisher<CocktailRepositoryModel, Error> in
                guard let self = self else {
                    return Fail(error: CocktailError.generalError)
                        .eraseToAnyPublisher()
                }
                return self.fetchFromNetworkDataSource(id: id)
            }
            .eraseToAnyPublisher()
    }

    // API doesn't retrieve an empty list, but nil instead when there are no drinks. In that case, map it manually to []
    func getCocktails(query: String) -> AnyPublisher<[CocktailSearchRepositoryModel], Error> {
        networkDataSource
            .getCocktails(query)
            .map { $0.drinks?.map { CocktailSearchRepositoryModel(from: $0) } ?? [] }
            .eraseToAnyPublisher()
    }

    func getFilter(for type: FilterType) -> AnyPublisher<FilterRepositoryModel, Error> {
        networkDataSource
            .getFilter(for: type)
            .map { FilterRepositoryModel(from: $0) }
            .eraseToAnyPublisher()
    }

    // API doesn't retrieve an empty list, but nil instead when there are no drinks. In that case, map it manually to []
    func getFilteredCocktails(
        model: AppliedFiltersRepositoryModel
    ) -> AnyPublisher<[CocktailSearchRepositoryModel], Error> {
        networkDataSource
            .getFilteredCocktails(model: model.toModel())
            .map { $0.drinks?.map { CocktailSearchRepositoryModel(from: $0) } ?? [] }
            .eraseToAnyPublisher()
    }

}

extension Repository {

    fileprivate func fetchFromLocalDataSource(id: String?) -> AnyPublisher<CocktailRepositoryModel, Error> {
        if let model = localDataSource.getCocktail(id: id) {
            return Just(CocktailRepositoryModel(from: model))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: CocktailError.generalError)
                .eraseToAnyPublisher()
        }
    }

    fileprivate func fetchFromNetworkDataSource(id: String?) -> AnyPublisher<CocktailRepositoryModel, Error> {
        networkDataSource
            .getCocktailDetails(id: id)
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
