import Combine
import Core

protocol UseCaseProtocol {

    func getDetails(id: String?) -> AnyPublisher<Result<CocktailModel>, Never>

    func searchCocktails(query: String) -> AnyPublisher<Result<[CocktailSearchCardModel]>, Never>

    var allFilters: AnyPublisher<Result<FiltersModel>, Never> { get }

    func applyFilter(model: AppliedFiltersModel) -> AnyPublisher<Result<[CocktailSearchCardModel]>, Never>

}
