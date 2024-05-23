import Combine

protocol UseCaseProtocol {

    func getDetails(id: String) -> AnyPublisher<DetailsModel, Error>

}
