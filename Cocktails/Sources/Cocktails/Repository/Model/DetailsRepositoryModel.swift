import Foundation

public struct DetailsRepositoryModel {

    let id: String
    let name: String
    let category: String?
    let glass: String?
    let alcoholicType: String?
    let instructions: String?
    let thumbnail: String?
    let ingredients: [String]
    let dateModified: Date?

}

extension DetailsRepositoryModel {

    init(from model: DetailsDataSourceModel) {
        id = model.id
        name = model.name
        category = model.category
        glass = model.glass
        alcoholicType = model.alcoholicType
        instructions = model.instructions
        thumbnail = model.thumbnail
        ingredients = model.ingredients
        dateModified = model.dateModified
    }

}
