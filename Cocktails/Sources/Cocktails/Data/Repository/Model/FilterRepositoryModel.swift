import Foundation

struct FilterRepositoryModel {

    let items: [String]

}

extension FilterRepositoryModel {

    init(from response: FiltersResponse) {
        self.items = response.drinks.map { $0.name }
    }

}
