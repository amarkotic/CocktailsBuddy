import Combine

protocol NetworkClientProtocol {

    func fetchDetails(id: String) -> AnyPublisher<DetailsNetworkModel, Error>

}
