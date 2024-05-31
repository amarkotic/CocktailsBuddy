import XCTest
import Combine
import RealmSwift
@testable import Cocktails

// swiftlint:disable force_try
final class LocalDataSourceTests: XCTestCase {

    var localDataSource: LocalDataSource!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        localDataSource = LocalDataSource()
        cancellables = []

        // Use an in-memory Realm for testing
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }

    override func tearDown() {
        localDataSource = nil
        cancellables = nil

        // Clean up Realm
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }

        super.tearDown()
    }

    func testSaveCocktail() {
        let cocktail = createSampleCocktail(id: "11007", name: "Margarita")
        localDataSource.saveCocktail(model: cocktail)

        let realm = try! Realm()
        let savedCocktail = realm.objects(CocktailLocalDSModel.self).filter("id == %@", "11007").first

        XCTAssertNotNil(savedCocktail)
        XCTAssertEqual(savedCocktail?.name, "Margarita")
    }

    func testUpdateCocktail() {
        let initialCocktail = createSampleCocktail(id: "11007", name: "Margarita")
        localDataSource.saveCocktail(model: initialCocktail)

        let updatedCocktail = createSampleCocktail(id: "11007", name: "Updated Margarita")
        localDataSource.saveCocktail(model: updatedCocktail)

        let realm = try! Realm()
        let savedCocktail = realm.objects(CocktailLocalDSModel.self).filter("id == %@", "11007").first

        XCTAssertNotNil(savedCocktail)
        XCTAssertEqual(savedCocktail?.name, "Updated Margarita")
    }

    // Helper method to create a sample cocktail
    private func createSampleCocktail(id: String, name: String) -> CocktailLocalDSModel {
        let cocktail = CocktailLocalDSModel()
        cocktail.id = id
        cocktail.name = name
        return cocktail
    }

}
// swiftlint:enable force_try
