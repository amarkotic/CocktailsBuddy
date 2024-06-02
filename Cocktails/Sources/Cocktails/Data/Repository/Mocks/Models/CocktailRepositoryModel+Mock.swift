import Foundation

extension CocktailRepositoryModel {

    static var mock: CocktailRepositoryModel {
        CocktailRepositoryModel(
            id: "11007",
            name: "Margarita",
            category: "Cocktail",
            glass: "Cocktail glass",
            alcoholicType: "Alcoholic",
            instructions: "Shake and strain into a chilled cocktail glass.",
            imageUrl: "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg",
            ingredients: ["1 1/2 oz Tequila", "1/2 oz Triple sec", "1 oz Lime juice"],
            dateModified: Date())
    }

}
