import Foundation

public struct DetailsDataSourceModel {

    let id: String
    let name: String
    let category: String?
    let glass: String?
    let alcoholicType: String?
    let instructions: String?
    let thumbnail: String?
    let ingredients: [String]
    let dateModified: Date?

    init(from model: DetailsNetworkModel) {
        self.id = model.id
        self.name = model.name ?? ""
        self.category = model.category
        self.glass = model.glass
        self.alcoholicType = model.alcoholicType
        self.instructions = model.instructions
        self.thumbnail = model.thumbnail
        self.ingredients = DetailsDataSourceModel.createIngredientsList(from: model)
        self.dateModified = DateFormatter.date(from: model.dateModified)
    }

    private static func createIngredientsList(from model: DetailsNetworkModel) -> [String] {
        var ingredients: [String] = []

        let ingredientMeasures = [
            (model.ingredient1, model.measure1),
            (model.ingredient2, model.measure2),
            (model.ingredient3, model.measure3),
            (model.ingredient4, model.measure4),
            (model.ingredient5, model.measure5),
            (model.ingredient6, model.measure6),
            (model.ingredient7, model.measure7),
            (model.ingredient8, model.measure8),
            (model.ingredient9, model.measure9),
            (model.ingredient10, model.measure10),
            (model.ingredient11, model.measure11),
            (model.ingredient12, model.measure12),
            (model.ingredient13, model.measure13),
            (model.ingredient14, model.measure14),
            (model.ingredient15, model.measure15)
        ]

        for (ingredient, measure) in ingredientMeasures {
            if let ingredient = ingredient, !ingredient.isEmpty {
                if let measure = measure, !measure.isEmpty {
                    ingredients.append("\(measure) \(ingredient)")
                } else {
                    ingredients.append(ingredient)
                }
            }
        }

        return ingredients
    }

}
