import Foundation

struct FiltersNetworkDSModel: Decodable {

    let filters: [FilterNetworkDSModel]?

    enum CodingKeys: String, CodingKey {

        case filters = "drinks"

    }

}
