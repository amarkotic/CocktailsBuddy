struct DetailsModel {

    let id: String
    let name: String
    let category: String
    let instructions: String
    let thumbnail: String
    let ingredients: [String]

}

extension DetailsModel {

    init(from model: DetailsRepositoryModel) {
        id = model.id
        name = model.name
        category = model.category
        instructions = model.instructions
        thumbnail = model.thumbnail
        ingredients = model.ingredients
    }

}
