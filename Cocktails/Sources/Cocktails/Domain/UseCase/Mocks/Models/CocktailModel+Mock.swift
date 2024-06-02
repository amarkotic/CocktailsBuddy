// swiftlint:disable line_length
extension CocktailModel {

    static var mock: CocktailModel {
        CocktailModel(
            id: "testId",
            name: "Margarita",
            category: "Cocktail",
            glass: "Glass",
            alcoholicType: "Alcoholic",
            instructions: "Place mint leaves and 1 lime wedge into a sturdy glass. Use a muddler and crush to release mint oils and lime juice. Add remaining lime wedges and 2 tablespoons sugar, and muddle again to release the lime juice. Do not strain the mixture. Fill the glass almost to the top with ice. Pour in rum and fill the glass with club soda. Stir, taste, and add more sugar if desired",
            imageUrl: "https://www.thecocktaildb.com/images/media/drink/wpxpvu1439905379.jpg",
            ingredients: ["0.3 dl white rum", "1 di club soda", "2 tbsp white sugar", "1/2 medium lime", "10v fresh mint leaves"],
            lastModified: .thisMonth)
    }

}
// swiftlint:enable line_length
