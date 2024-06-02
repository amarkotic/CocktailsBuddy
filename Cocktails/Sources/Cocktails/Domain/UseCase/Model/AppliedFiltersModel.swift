public struct AppliedFiltersModel {

    let alcohol: String?
    let category: String?
    let glass: String?

}

extension AppliedFiltersModel {

    func toModel() -> AppliedFiltersRepositoryModel {
        AppliedFiltersRepositoryModel(alcohol: alcohol, category: category, glass: glass)
    }

}
