import Foundation
import Dependencies
import RealmSwift
import Core

// Local DB in this project enables users to access cocktail details they already accessed even without internet access
// It is simply a prototype for cocktail details model and could be used for other features as well in the future
public class LocalDataSource: LocalDataSourceProtocol, DependencyKey {

    public static let liveValue: any LocalDataSourceProtocol = LocalDataSource()
    public static let testValue: any LocalDataSourceProtocol = LocalDataSource()

    // Get cocktail model from local DB - return specific model if id is not nil, and a random model if id is nil
    public func getCocktail(id: String?) -> CocktailLocalDSModel? {
        guard let realm = try? Realm() else { return nil }

        let persistedObject = id != nil ?
            realm.objects(CocktailLocalDSModel.self).filter("id == %@", id!).first :
            realm.objects(CocktailLocalDSModel.self).randomElement()

        return persistedObject
    }

    // Add the cocktail model to local DB, and in case model with that id already exists, delete the old one
    public func saveCocktail(model: CocktailLocalDSModel) {
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

    public var localDataSource: LocalDataSourceProtocol {
        get { self[LocalDataSource.self] }
        set { self[LocalDataSource.self] = newValue }
    }

}
