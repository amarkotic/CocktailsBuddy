import XCTest

final class CocktailsBuddyUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.state == .runningForeground, "App did not launch correctly")

        app.terminate()
        XCTAssertFalse(app.state == .runningForeground, "App did not terminate correctly")
    }

    func testDetails() throws {
        let app = XCUIApplication()
        app.launch()

        let element = app.scrollViews
            .children(matching: .other)
            .element
            .children(matching: .other)
            .element.children(matching: .image)
            .element(boundBy: 3)

        XCTAssertTrue(element.exists, "The specified element does not exist")
        element.tap()

        XCTAssertTrue(app.buttons["back"].exists, "Detail view did not load correctly")

        app.buttons["back"].tap()
        XCTAssertTrue(app.scrollViews.count > 0, "Did not return to main screen correctly")
    }

    func testSearch() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.textFields["Type to search"].exists, "Search field does not exist")
        app.textFields["Type to search"].tap()

        let kKey = app.keys["M"]
        kKey.tap()

        let oKey = app.keys["o"]
        oKey.tap()

        let nKey = app.keys["j"]
        nKey.tap()

        let searchResult = app.scrollViews
            .children(matching: .other)
            .element
            .children(matching: .other)
            .element.children(matching: .image)
            .element(boundBy: 1)
        XCTAssertTrue(searchResult.exists, "Search result does not exist")
        searchResult.tap()
    }

    func testFilter() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.images["filter"].exists, "Filter button does not exist")
        app.images["filter"].tap()

        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements

        XCTAssertTrue(elementsQuery.staticTexts["Coffee / Tea"].exists, "Filter option 'Coffee / Tea' does not exist")
        elementsQuery.staticTexts["Coffee / Tea"].tap()

        XCTAssertTrue(elementsQuery.staticTexts["Cocktail glass"].exists)
        elementsQuery.staticTexts["Cocktail glass"].tap()

        XCTAssertTrue(app.buttons["RESET"].exists, "Reset button does not exist")
        app.buttons["RESET"].tap()

        XCTAssertTrue(scrollViewsQuery.otherElements.containing(.staticText, identifier: "Category:").element.exists)

        XCTAssertTrue(app.buttons["SEARCH"].exists, "Search button does not exist")
        app.buttons["SEARCH"].tap()

        XCTAssertTrue(app.scrollViews.count > 0, "Search results did not load correctly after applying filters")

        XCTAssertTrue(app.buttons["back"].exists, "Back button does not exist")
        app.buttons["back"].tap()

        XCTAssertTrue(app.scrollViews.count > 0, "Did not return to main screen correctly after applying filters")
    }

}
