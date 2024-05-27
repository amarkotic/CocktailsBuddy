import Foundation

struct DrinksNetworkModel: Decodable {

    let drinks: [DetailsNetworkModel]

    var firstDrink: DetailsNetworkModel {
        drinks.first!
    }

}
