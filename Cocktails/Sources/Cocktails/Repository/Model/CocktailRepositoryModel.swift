import Foundation

struct CocktailRepositoryModel {

    let id: String
    let title: String?
    let description: String
    let imageUrl: String?

}

extension CocktailRepositoryModel {

    init(from model: CocktailDataSourceModel) {
        id = model.id
        title = model.title
        description = model.description
        imageUrl = model.imageUrl
    }

}
