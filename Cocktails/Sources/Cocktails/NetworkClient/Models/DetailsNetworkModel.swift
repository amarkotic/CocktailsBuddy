import Foundation

struct DetailsNetworkModel: Decodable {

    let id: String
    let name: String
    let category: String
    let instructions: String
    let thumbnail: String
    let ingredients: [String]

    enum CodingKeys: String, CodingKey {

        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case instructions = "strInstructions"
        case thumbnail = "strDrinkThumb"
        case ingredients

    }

}
