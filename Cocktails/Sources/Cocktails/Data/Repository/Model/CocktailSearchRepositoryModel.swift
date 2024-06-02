import Foundation

struct CocktailSearchRepositoryModel {

    let id: String
    let name: String
    let description: String
    let imageUrl: String?

}

extension CocktailSearchRepositoryModel {

    init(from model: CocktailSearchNetworkDSModel) {
        id = model.id
        name = model.name ?? LocalizableStrings.cocktail.localized
        description = [
            model.ingredient1,
            model.ingredient2,
            model.ingredient3,
            model.ingredient4,
            model.ingredient5,
            model.ingredient6,
            model.ingredient7,
            model.ingredient8,
            model.ingredient9,
            model.ingredient10,
            model.ingredient11,
            model.ingredient12,
            model.ingredient13,
            model.ingredient14,
            model.ingredient15
        ]
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
