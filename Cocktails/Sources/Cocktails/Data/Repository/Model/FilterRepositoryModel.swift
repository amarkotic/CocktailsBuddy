import Foundation

struct FilterRepositoryModel {

    let items: [String]

}

extension FilterRepositoryModel {

    init(from response: FiltersNetworkDSModel) {
        self.items = response.drinks.map { $0.name }
    }

}
