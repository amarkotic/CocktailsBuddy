import Foundation

struct CocktailDataSourceModel {

    let id: String
    let title: String?
    let description: String
    let imageUrl: String?

}

extension CocktailDataSourceModel {

    init(from model: DetailsNetworkModel) {
        id = model.id
        title = model.name
        description = [model.alcoholicType, model.category, model.glass]
            .compactMap { $0 }
            .joined(separator: ", ")
        imageUrl = model.imageUrl
    }

}
