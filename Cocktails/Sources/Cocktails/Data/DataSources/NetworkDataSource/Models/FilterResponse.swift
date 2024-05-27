import Foundation

struct FilterResponse: Decodable {

    let name: String

    enum CodingKeys: String, CodingKey {

        case category = "strCategory"
        case alcoholic = "strAlcoholic"
        case glass = "strGlass"

    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let name = try container.decodeIfPresent(String.self, forKey: .category) {
            self.name = name
        } else if let name = try container.decodeIfPresent(String.self, forKey: .alcoholic) {
            self.name = name
        } else if let name = try container.decodeIfPresent(String.self, forKey: .glass) {
            self.name = name
        } else {
            self.name = ""
        }
    }

}
