public struct AppliedFiltersModel {

    var alcohol: String?
    var category: String?
    var glass: String?

}

extension AppliedFiltersModel {

    static var empty: AppliedFiltersModel {
        AppliedFiltersModel(alcohol: nil, category: nil, glass: nil)
    }

    func toModel() -> AppliedFiltersRepositoryModel {
        AppliedFiltersRepositoryModel(alcohol: alcohol, category: category, glass: glass)
    }

    mutating func reset() {
        alcohol = nil
        category = nil
        glass = nil
    }

}
