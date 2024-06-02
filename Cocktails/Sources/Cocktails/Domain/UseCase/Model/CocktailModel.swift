import Foundation

struct CocktailModel: Equatable {

    let id: String
    let name: String
    let category: String?
    let glass: String?
    let alcoholicType: String?
    let instructions: String?
    let imageUrl: String?
    let ingredients: [String]
    let lastModified: LastModified?

    var url: URL? {
        guard let imageUrl else { return nil }

        return URL(string: imageUrl)
    }

}

extension CocktailModel {

    init(from model: CocktailRepositoryModel) {
        id = model.id
        name = model.name ?? LocalizableStrings.cocktail.localized
        category = model.category
        glass = model.glass
        alcoholicType = model.alcoholicType
        instructions = model.instructions
        imageUrl = model.imageUrl
        ingredients = model.ingredients
        lastModified = LastModified(from: model.dateModified)
    }

}
