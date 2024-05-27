struct AppliedFiltersRepositoryModel {

    let alcohol: String?
    let category: String?
    let glass: String?

}

extension AppliedFiltersRepositoryModel {

    func toModel() -> AppliedFiltersNetworkDataSourceModel {
        AppliedFiltersNetworkDataSourceModel(
            alcohol: alcohol?.configuredForRequest,
            category: category?.configuredForRequest,
            glass: glass?.configuredForRequest)
    }

}
