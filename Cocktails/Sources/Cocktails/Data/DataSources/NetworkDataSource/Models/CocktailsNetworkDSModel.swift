import Foundation

struct CocktailsNetworkDSModel: Decodable {

    let drinks: [CocktailNetworkDSModel]

    var firstDrink: CocktailNetworkDSModel? {
        drinks.first
    }

}
