import Combine
import RealmSwift
import Core

public class LocalDataSourceMock: LocalDataSourceProtocol {

    private var realm: Realm

    public init() {
        let configuration = Realm.Configuration(inMemoryIdentifier: "TestingRealm")
        self.realm = try! Realm(configuration: configuration)
    }

    public func getCocktail(id: String?) -> CocktailLocalDSModel? {
        guard let id = id else { return nil }
        return realm.objects(CocktailLocalDSModel.self).filter("id == %@", id).first
    }

    public func saveCocktail(model: CocktailLocalDSModel) {
        do {
            try realm.write {
                if let oldCocktail = realm.objects(CocktailLocalDSModel.self).filter("id == %@", model.id).first {
                    realm.delete(oldCocktail)
                }
                realm.add(model)
            }
        } catch {
            print("Failed to save cocktail: \(error)")
        }
    }

    public func cleanup() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Failed to clean up Realm: \(error)")
        }
    }

}
