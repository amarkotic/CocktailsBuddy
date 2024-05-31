import Combine
import Foundation
import Dependencies
import RealmSwift
import Core

// Local DB in this project enables users to access cocktail details they already accessed even without internet access
// It is simply a prototype for cocktail details model and could be used for other features as well in the future

class LocalDataSource: LocalDataSourceProtocol, DependencyKey {

    static var liveValue: any LocalDataSourceProtocol = LocalDataSource()
    static var testValue: any LocalDataSourceProtocol = LocalDataSource()

    // Get cocktail model from local DB - return specific model if id is not nil, and a random model if id is nil
    func getCocktailDetails(id: String?) -> AnyPublisher<CocktailLocalDSModel, Error> {
        guard let realm = try? Realm() else { return .never() }

        let object = id != nil ?
            realm.objects(CocktailLocalDSModel.self).filter("id == %@", id!).first :
            realm.objects(CocktailLocalDSModel.self).randomElement()

        if let object = object {
            return Just(object)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "No data found", code: 0, userInfo: nil))
                .eraseToAnyPublisher()
        }
    }

    // Add the cocktail model to local DB, and in case model with that id already exists, delete the old one
    func saveCocktail(model: CocktailLocalDSModel) {
        guard let realm = try? Realm() else { return }

        do {
            try realm.write {
                if let oldCocktail = realm.objects(CocktailLocalDSModel.self).filter("id == %@", model.id).first {
                    realm.delete(oldCocktail)
                }
                realm.add(model)
            }
        } catch {
            print("Failed to save model to local DB \(model)")
        }
    }

}

extension DependencyValues {

    var localDataSource: LocalDataSourceProtocol {
        get { self[LocalDataSource.self] }
        set { self[LocalDataSource.self] = newValue }
    }

}
