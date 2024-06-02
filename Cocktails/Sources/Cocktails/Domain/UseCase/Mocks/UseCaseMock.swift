import Combine
import Core

public class UseCaseMock: UseCaseProtocol {

    func getCocktailDetails(id: String?) -> AnyPublisher<Result<CocktailModel>, Never> {
        let mockCocktail = CocktailModel.mock

        return Just(.success(mockCocktail))
            .eraseToAnyPublisher()
    }

    func getCocktails(query: String) -> AnyPublisher<Result<[CocktailCardModel]>, Never> {
        let mockCocktails = [CocktailCardModel.mock]

        return Just(.success(mockCocktails))
            .eraseToAnyPublisher()
    }

    var allFilters: AnyPublisher<Result<FiltersModel>, Never> {
        let mockFilters = FiltersModel.mock

        return Just(.success(mockFilters))
            .eraseToAnyPublisher()
    }

    func getFilteredCocktails(model: AppliedFiltersModel) -> AnyPublisher<Result<[CocktailCardModel]>, Never> {
        let mockFilteredCocktails = [CocktailCardModel.mock]

        return Just(.success(mockFilteredCocktails))
            .eraseToAnyPublisher()
    }

}
