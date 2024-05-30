import Combine
import Dependencies
import Core

class UseCase: UseCaseProtocol, DependencyKey {

    static var liveValue: any UseCaseProtocol = UseCase()

    @Dependency(\.repository) private var repository: RepositoryProtocol

    func getDetails(id: String?) -> AnyPublisher<Result<CocktailModel>, Never> {
        repository
            .getDetails(id: id)
            .map { CocktailModel(from: $0) }
            .mapToNonFailingResult()
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
            .mapToNonFailingResult()
    }

    var allFilters: AnyPublisher<Result<FiltersModel>, Never> {
        Publishers.Zip3(
            repository.getFilter(for: .alcohol),
            repository.getFilter(for: .glass),
            repository.getFilter(for: .category))
        .map { alcoholicResponse, glassResponse, categoryResponse in
            FiltersModel(
                alcoholicFilterItems: alcoholicResponse.items,
                glassFilterItems: glassResponse.items,
                categoryFilterItems: categoryResponse.items)
        }
        .mapToNonFailingResult()
    }

    func applyFilter(model: AppliedFiltersModel) -> AnyPublisher<Result<[CocktailSearchCardModel]>, Never> {
        repository
            .applyFilter(model: model.toModel())
            .map { $0.sorted { $0 < $1 } }
            .map { cocktails in
                 cocktails.enumerated().map { index, item in
                     CocktailSearchCardModel(from: item, isLastItem: index == cocktails.count - 1)
                 }
             }
            .mapToNonFailingResult()
    }

}

extension DependencyValues {

    var useCase: UseCaseProtocol {
        get { self[UseCase.self] }
        set { self[UseCase.self] = newValue }
    }

}
