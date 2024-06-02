import Combine
import Core

public class RepositoryMock: RepositoryProtocol {
    func getCocktailDetails(id: String?) -> AnyPublisher<CocktailRepositoryModel, any Error> {
        if id == "11007" {
            Just(CocktailRepositoryModel.mock)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            Fail(error: CocktailError.generalError)
                .eraseToAnyPublisher()
        }
    }

    func getCocktails(query: String) -> AnyPublisher<[CocktailSearchRepositoryModel], any Error> {
        return Just([CocktailSearchRepositoryModel.mock])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func getFilter(for type: FilterType) -> AnyPublisher<FilterRepositoryModel, any Error> {
        return Just(FilterRepositoryModel.mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func getFilteredCocktails(model: AppliedFiltersRepositoryModel) -> AnyPublisher<[CocktailSearchRepositoryModel], any Error> {
        return Just([CocktailSearchRepositoryModel.mock])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

}
