import Foundation

struct CocktailSearchCardModel: Identifiable {

    let id: String
    let title: String
    let description: String
    let imageUrl: String?

    var url: URL? {
        guard let imageUrl else { return nil }

        // Adding /preview to the imageURL decreases image size by 4-5 times by API documentation. Images from this
        // model will only be displayed in small cards inside a lazyvstack, so we want to fetch them as fast as possible
        return URL(string: imageUrl.appending("/preview")) ?? URL(string: imageUrl)
    }

}

extension CocktailSearchCardModel {

    init(from model: CocktailSearchRepositoryModel) {
        id = model.id
        title = model.name ?? LocalizableStrings.cocktail.localized
        description = model.description
        imageUrl = model.imageUrl
    }

}

extension CocktailSearchCardModel {

    static var mock: CocktailSearchCardModel {
        CocktailSearchCardModel(
            id: "24214",
            title: "Mojito",
            description: "Alcoholic, Beverage, Regular glass",
            imageUrl: "https://www.thecocktaildb.com/images/media/drink/wpxpvu1439905379.jpg")
    }

}
