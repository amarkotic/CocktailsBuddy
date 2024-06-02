import XCTest
import Combine
import RealmSwift
import Dependencies
@testable import Cocktails

final class LocalDataSourceTests: XCTestCase {

    @Dependency(\.localDataSource) private var localDataSource: LocalDataSourceProtocol

    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil

        // Clean up Realm
        if let localDataSourceMock = localDataSource as? LocalDataSourceMock {
            localDataSourceMock.cleanup()
        }

        super.tearDown()
    }

    func testSaveCocktail() {
        let cocktail = CocktailLocalDSModel.mock
        localDataSource.saveCocktail(model: cocktail)

        let savedCocktail = localDataSource.getCocktail(id: "11007")

        XCTAssertNotNil(savedCocktail)
        XCTAssertEqual(savedCocktail?.name, "Margarita")
    }

    func testUpdateCocktail() {
        let initialCocktail = CocktailLocalDSModel.mock
        localDataSource.saveCocktail(model: initialCocktail)

        // Create an updated mock with the same ID but a different name
        let updatedCocktail = CocktailLocalDSModel()
        updatedCocktail.id = "11007"
        updatedCocktail.name = "Updated Margarita"
        updatedCocktail.category = initialCocktail.category
        updatedCocktail.glass = initialCocktail.glass
        updatedCocktail.alcoholicType = initialCocktail.alcoholicType
        updatedCocktail.instructions = initialCocktail.instructions
        updatedCocktail.imageUrl = initialCocktail.imageUrl
        updatedCocktail.ingredients.append(objectsIn: initialCocktail.ingredients)
        updatedCocktail.dateModified = initialCocktail.dateModified

        localDataSource.saveCocktail(model: updatedCocktail)

        let savedCocktail = localDataSource.getCocktail(id: "11007")

        XCTAssertNotNil(savedCocktail)
        XCTAssertEqual(savedCocktail?.name, "Updated Margarita")
    }

}
