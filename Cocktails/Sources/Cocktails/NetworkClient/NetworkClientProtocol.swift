import Combine

protocol NetworkClientProtocol {

    func fetchDetails(id: String) -> AnyPublisher<DrinksNetworkModel, Error>

    func searchCocktails(_ query: String) -> AnyPublisher<DrinksNetworkModel, Error>

}
