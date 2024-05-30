import Foundation

struct FilterRepositoryModel {

    let items: [String]

}

extension FilterRepositoryModel {

    // API doesn't retrieve an empty list, but nil when there are no filters. In that case, map it manually to []
    init(from response: FiltersNetworkDSModel) {
        self.items = response.filters?.map { $0.name } ?? []
    }

}
