import XCTest
import Combine
import RealmSwift
@testable import Cocktails

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
        let savedCocktail =  realm.objects(CocktailLocalDSModel.self).filter("id == %@", "11007").first

        XCTAssertNotNil(savedCocktail)
        XCTAssertEqual(savedCocktail?.name, "Margarita")
    }

    func testRetrieveCocktailById() {
        let expectation = self.expectation(description: "Retrieve cocktail by id")
        let cocktail = createSampleCocktail(id: "11007", name: "Margarita")
        localDataSource.saveCocktail(model: cocktail)

        localDataSource.getCocktailDetails(id: "11007")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Request failed with error: \(error)")
                }
            }, receiveValue: { retrievedCocktail in
                XCTAssertEqual(retrievedCocktail.name, "Margarita")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

    func testRetrieveRandomCocktail() {
        let expectation = self.expectation(description: "Retrieve random cocktail")
        let cocktail1 = createSampleCocktail(id: "11007", name: "Margarita")
        let cocktail2 = createSampleCocktail(id: "11008", name: "Mojito")
        localDataSource.saveCocktail(model: cocktail1)
        localDataSource.saveCocktail(model: cocktail2)

        localDataSource.getCocktailDetails(id: nil)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Request failed with error: \(error)")
                }
            }, receiveValue: { retrievedCocktail in
                XCTAssertTrue(["Margarita", "Mojito"].contains(retrievedCocktail.name))
                expectation.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
    }

    func testRetrieveCocktailNotFound() {
        let expectation = self.expectation(description: "Retrieve non-existent cocktail should fail")

        localDataSource.getCocktailDetails(id: "99999")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (No data found error 0.)")
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Request should not succeed")
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5.0)
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
