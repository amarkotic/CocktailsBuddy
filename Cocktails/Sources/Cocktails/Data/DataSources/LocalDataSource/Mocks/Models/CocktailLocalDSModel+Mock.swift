import Foundation

extension CocktailLocalDSModel {

    static var mock: CocktailLocalDSModel {
        let cocktail = CocktailLocalDSModel()
        cocktail.id = "11007"
        cocktail.name = "Margarita"
        cocktail.category = "Cocktail"
        cocktail.glass = "Cocktail glass"
        cocktail.alcoholicType = "Alcoholic"
        cocktail.instructions = "Shake and strain into a chilled cocktail glass."
        cocktail.imageUrl = "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg"
        cocktail.ingredients.append(objectsIn: ["1 1/2 oz Tequila", "1/2 oz Triple sec", "1 oz Lime juice"])
        cocktail.dateModified = Date()
        return cocktail
    }

}
