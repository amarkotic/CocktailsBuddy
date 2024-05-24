import Combine

protocol NetworkClientProtocol {

    func fetchDetails(id: String) -> AnyPublisher<DrinksNetworkModel, Error>

}
