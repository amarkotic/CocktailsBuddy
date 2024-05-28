import Foundation

struct CocktailSearchRepositoryModel {

    let id: String
    let name: String
    let description: String
    let imageUrl: String?

}

extension CocktailSearchRepositoryModel {

    init(from model: CocktailSearchResponse) {
        id = model.id
        name = model.name ?? LocalizableStrings.cocktail.localized
        description = [model.alcoholicType, model.category, model.glass]
            .compactMap { $0 }
            .joined(separator: ", ")
        imageUrl = model.imageUrl
    }

}

extension CocktailSearchRepositoryModel: Comparable {

    static func <(lhs: CocktailSearchRepositoryModel, rhs: CocktailSearchRepositoryModel) -> Bool {
        lhs.name < rhs.name
    }

}
