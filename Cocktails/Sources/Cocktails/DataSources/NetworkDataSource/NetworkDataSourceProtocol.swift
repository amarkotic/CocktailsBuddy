import Combine

protocol NetworkDataSourceProtocol {

    func fetchDetails(id: String?) -> AnyPublisher<DrinksNetworkModel, Error>

    func searchCocktails(_ query: String) -> AnyPublisher<DrinksNetworkModel, Error>

    func fetchFilter(for type: FilterType) -> AnyPublisher<FilterResponse, Error>

}
