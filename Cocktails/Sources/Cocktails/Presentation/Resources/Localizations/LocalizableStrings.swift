import CoreUI

enum LocalizableStrings: String, Localizable {

    case dot
    case today
    case thisWeek = "this.week"
    case thisMonth = "this.month"
    case thisYear = "this.year"
    case yearsAgo = "years.ago"

    case ingredientsTitle = "ingredients.title"
    case directionsTitle = "directions.title"
    case lastModifiedTitle = "last.modified.title"

    case noSearchResult = "no.search.result"
    case cocktail
    case feelingLucky = "feeling.lucky"

    case category
    case glass
    case alcohol

    case search
    case reset
    case filteredResult = "filtered.result"

    public var localized: String {
        rawValue.localize(bundle: .module)
    }

}
