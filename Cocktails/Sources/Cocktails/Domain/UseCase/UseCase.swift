import Combine
import Dependencies
import Core

class UseCase: UseCaseProtocol, DependencyKey {

    static var liveValue: any UseCaseProtocol = UseCase()

    @Dependency(\.repository) private var repository: RepositoryProtocol

    func getDetails(id: String?) -> AnyPublisher<CocktailModel, Error> {
        repository
            .getDetails(id: id)
            .map { CocktailModel(from: $0) }
            .eraseToAnyPublisher()
    }

    // Get search results, sort them alphabeticaly by title, apply isLast paramter and mark result as success
    func searchCocktails(query: String) -> AnyPublisher<Result<[CocktailSearchCardModel]>, Never> {
        repository
            .searchCocktails(query: query)
            .map { $0.sorted { $0 < $1 } }
            .map { cocktails in
                 cocktails.enumerated().map { index, item in
                     CocktailSearchCardModel(from: item, isLastItem: index == cocktails.count - 1)
                 }
             }
            .map { .success($0) }
            .catch { _ in Just(.failure) } // Map thrown error to Result's failure to avoid breaking the chain
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
            .map { $0.sorted { $0 < $1 } }
            .map { cocktails in
                 cocktails.enumerated().map { index, item in
                     CocktailSearchCardModel(from: item, isLastItem: index == cocktails.count - 1)
                 }
             }
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
