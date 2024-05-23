import Foundation

public struct DrinksNetworkModel: Decodable {

    let drinks: [DetailsNetworkModel]

    public var firstDrink: DetailsNetworkModel {
        drinks.first!
    }

}
