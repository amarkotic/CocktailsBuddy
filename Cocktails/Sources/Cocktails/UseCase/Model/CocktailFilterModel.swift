struct CocktailFilterModel {

    let alcoholicFilterItems: [String]
    let glassFilterItems: [String]
    let categoryFilterItems: [String]

}

extension CocktailFilterModel {

    static var empty: CocktailFilterModel {
        CocktailFilterModel(alcoholicFilterItems: [], glassFilterItems: [], categoryFilterItems: [])
    }

}
