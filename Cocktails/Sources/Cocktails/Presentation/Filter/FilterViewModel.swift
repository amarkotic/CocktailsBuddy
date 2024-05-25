import Combine
import Foundation
import Dependencies

class FilterViewModel: ObservableObject {

    @Dependency(\.useCase) private var useCase: UseCaseProtocol

    private var cancellables = Set<AnyCancellable>()

    func fetchFilters() { }

}
