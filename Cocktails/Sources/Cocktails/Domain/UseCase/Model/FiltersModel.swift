struct FiltersModel {

    let alcoholicFilterItems: [String]
    let glassFilterItems: [String]
    let categoryFilterItems: [String]

}

extension FiltersModel {

    static var empty: FiltersModel {
        FiltersModel(alcoholicFilterItems: [], glassFilterItems: [], categoryFilterItems: [])
    }

}
