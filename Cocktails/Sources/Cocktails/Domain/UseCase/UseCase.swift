import Combine
import Dependencies
import Core

class UseCase: UseCaseProtocol, DependencyKey {

    static let liveValue: any UseCaseProtocol = UseCase()
    static let testValue: any UseCaseProtocol = UseCaseMock()

    @Dependency(\.repository) private var repository: RepositoryProtocol

    // Get detailed model for a single cocktail
    func getCocktailDetails(id: String?) -> AnyPublisher<Result<CocktailModel>, Never> {
        repository
            .getCocktailDetails(id: id)
            .map { CocktailModel(from: $0) }
            .mapToNonFailingResult()
    }

    // Get search results, sort them alphabeticaly by title, apply isLast paramter and mark result as success
    func getCocktails(query: String) -> AnyPublisher<Result<[CocktailCardModel]>, Never> {
        repository
            .getCocktails(query: query)
            .map { $0.sorted { $0 < $1 } }
            .map { cocktails in
                 cocktails.enumerated().map { index, item in
                     CocktailCardModel(from: item, isLastItem: index == cocktails.count - 1)
                 }
             }
            .mapToNonFailingResult()
    }

    // Get all three filters and zip them into one model
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

    // Get cocktails which corespond to applied filters
    func getFilteredCocktails(model: AppliedFiltersModel) -> AnyPublisher<Result<[CocktailCardModel]>, Never> {
        repository
            .getFilteredCocktails(model: model.toModel())
            .map { $0.sorted { $0 < $1 } }
            .map { cocktails in
                 cocktails.enumerated().map { index, item in
                     CocktailCardModel(from: item, isLastItem: index == cocktails.count - 1)
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
