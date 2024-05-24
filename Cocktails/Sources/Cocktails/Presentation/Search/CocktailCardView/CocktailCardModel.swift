import Foundation

struct CocktailCardModel: Identifiable {

    let id: String
    let title: String
    let description: String
    let imageUrl: String?

    var url: URL? {
        guard let imageUrl else { return nil }

        return URL(string: imageUrl)
    }

}

extension CocktailCardModel {

    init(from model: DetailsDataSourceModel) {
        id = model.id
        title = model.name ?? LocalizableStrings.cocktail.localized
        description = [model.alcoholicType, model.category, model.glass]
            .compactMap { $0 }
            .joined(separator: ", ")
        imageUrl = model.imageUrl
    }

}

extension CocktailCardModel {

    static var mock: CocktailCardModel {
        CocktailCardModel(
            id: "24214",
            title: "Mojito",
            description: "Alcoholic, Beverage, Regular glass",
            imageUrl: "https://www.thecocktaildb.com/images/media/drink/wpxpvu1439905379.jpg")
    }

}
