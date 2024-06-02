import Combine
import Core

protocol UseCaseProtocol {

    func getCocktailDetails(id: String?) -> AnyPublisher<Result<CocktailModel>, Never>

    func getCocktails(query: String) -> AnyPublisher<Result<[CocktailCardModel]>, Never>

    var allFilters: AnyPublisher<Result<FiltersModel>, Never> { get }

    func getFilteredCocktails(model: AppliedFiltersModel) -> AnyPublisher<Result<[CocktailCardModel]>, Never>

}
