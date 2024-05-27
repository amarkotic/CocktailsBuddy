import Foundation

struct CocktailsResponse: Decodable {

    let drinks: [CocktailResponse]

    var firstDrink: CocktailResponse? {
        drinks.first
    }

}
