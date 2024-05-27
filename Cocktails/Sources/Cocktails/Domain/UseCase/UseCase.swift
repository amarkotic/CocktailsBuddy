import Combine
import Dependencies

class UseCase: UseCaseProtocol, DependencyKey {

    static var liveValue: any UseCaseProtocol = UseCase()

    @Dependency(\.repository) private var repository: RepositoryProtocol

    func getDetails(id: String?) -> AnyPublisher<CocktailModel, Error> {
        repository
            .getDetails(id: id)
            .map { CocktailModel(from: $0) }
            .eraseToAnyPublisher()
    }

    func searchCocktails(query: String) -> AnyPublisher<[CocktailSearchCardModel], Never> {
        repository
            .searchCocktails(query: query)
            .map { $0.map { CocktailSearchCardModel(from: $0)} }
            .catch { _ in Just([]) } // In case request fails, return an empty array insted of breaking the chain
            .eraseToAnyPublisher()
    }

    var allFilters: AnyPublisher<FiltersModel, Error> {
        Publishers.Zip3(
            repository.getFilter(for: .alcohol),
            repository.getFilter(for: .glass),
            repository.getFilter(for: .category))
        .map { alcoholicResponse, glassResponse, categoryResponse in
            FiltersModel(
                alcoholicFilterItems: alcoholicResponse.items,
                glassFilterItems: glassResponse.items,
                categoryFilterItems: categoryResponse.items
            )
        }
        .eraseToAnyPublisher()
    }

    func applyFilter(model: AppliedFiltersModel) -> AnyPublisher<[CocktailSearchCardModel], Never> {
        repository
            .applyFilter(model: model.toModel())
            .map { $0.map { CocktailSearchCardModel(from: $0) }}
            .catch { _ in Just([]) } // In case request fails, return an empty array insted of breaking the chain
            .eraseToAnyPublisher()
    }

}

extension DependencyValues {

    var useCase: UseCaseProtocol {
        get { self[UseCase.self] }
        set { self[UseCase.self] = newValue }
    }

}
