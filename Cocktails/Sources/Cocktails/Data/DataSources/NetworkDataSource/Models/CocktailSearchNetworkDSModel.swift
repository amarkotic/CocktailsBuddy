import Foundation

struct CocktailSearchNetworkDSModel: Decodable {

    let id: String
    let name: String?
    let category: String?
    let glass: String?
    let alcoholicType: String?
    let imageUrl: String?

    enum CodingKeys: String, CodingKey {

        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case glass = "strGlass"
        case alcoholicType = "strAlcoholic"
        case imageUrl = "strDrinkThumb"

    }

}
