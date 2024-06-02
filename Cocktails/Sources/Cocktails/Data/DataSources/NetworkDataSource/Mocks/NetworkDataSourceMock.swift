import Combine
import Foundation
import Networking

class NetworkDataSourceMock: NetworkDataSourceProtocol {

    func getCocktailDetails(id: String?) -> AnyPublisher<CocktailNetworkDSModel, Error> {
        Just(CocktailNetworkDSModel.mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func getCocktails(_ query: String) -> AnyPublisher<CocktailsSearchNetworkDSModel, Error> {
        Just(CocktailsSearchNetworkDSModel.mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func getFilter(for type: FilterType) -> AnyPublisher<FiltersNetworkDSModel, Error> {
        Just(FiltersNetworkDSModel.mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func getFilteredCocktails(
        model: AppliedFiltersNetworkDSModel
    ) -> AnyPublisher<CocktailsSearchNetworkDSModel, Error> {
        Just(CocktailsSearchNetworkDSModel.mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

}
