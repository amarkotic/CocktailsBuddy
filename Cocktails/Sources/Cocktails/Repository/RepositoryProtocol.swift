import Combine

protocol RepositoryProtocol {

    func getDetails(id: String) -> AnyPublisher<DetailsRepositoryModel, Error>

}
