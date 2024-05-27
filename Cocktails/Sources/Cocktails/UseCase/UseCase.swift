import Combine
import Dependencies

class UseCase: UseCaseProtocol, DependencyKey {

    static var liveValue: any UseCaseProtocol = UseCase()

    @Dependency(\.repository) private var repository: RepositoryProtocol

    func getDetails(id: String?) -> AnyPublisher<DetailsModel, Error> {
        repository
            .getDetails(id: id)
            .map { DetailsModel(from: $0) }
            .eraseToAnyPublisher()
    }

    func searchCocktails(query: String) -> AnyPublisher<[CocktailCardModel], Never> {
        repository
            .searchCocktails(query: query)
            .map { $0.map { CocktailCardModel(from: $0)} }
            .catch { _ in Just([]) } // In case request fails, return an empty array insted of breaking the chain
            .eraseToAnyPublisher()
    }

    var allFilters: AnyPublisher<CocktailFilterModel, Error> {
        Publishers.Zip3(
            repository.getFilter(for: .alcohol),
            repository.getFilter(for: .glass),
            repository.getFilter(for: .category))
        .map { alcoholicResponse, glassResponse, categoryResponse in
            CocktailFilterModel(
                alcoholicFilterItems: alcoholicResponse.items,
                glassFilterItems: glassResponse.items,
                categoryFilterItems: categoryResponse.items
            )
        }
        .eraseToAnyPublisher()
    }

}

extension DependencyValues {

    var useCase: UseCaseProtocol {
        get { self[UseCase.self] }
        set { self[UseCase.self] = newValue }
    }

}
