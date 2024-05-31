import Foundation
import RealmSwift

// Realm needs classes to maintain object identity and data consistency
public class CocktailLocalDSModel: Object {

    @Persisted public var id: String
    @Persisted public var name: String?
    @Persisted var category: String?
    @Persisted var glass: String?
    @Persisted var alcoholicType: String?
    @Persisted var instructions: String?
    @Persisted var imageUrl: String?
    @Persisted var ingredients: List<String>
    @Persisted var dateModified: Date?

}

extension CocktailLocalDSModel {

    convenience init(from model: CocktailNetworkDSModel) {
        self.init()

        id = model.id
        name = model.name
        category = model.category
        glass = model.glass
        alcoholicType = model.alcoholicType
        instructions = model.instructions
        imageUrl = model.imageUrl
        ingredients.append(objectsIn: CocktailRepositoryModel.createIngredientsList(from: model))
        dateModified = DateFormatter.date(from: model.dateModified)
    }

}
