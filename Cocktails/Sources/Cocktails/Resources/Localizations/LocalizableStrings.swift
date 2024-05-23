import CoreUI

public enum LocalizableStrings: String, Localizable {

    case today
    case thisWeek = "this.week"
    case thisMonth = "this.month"
    case thisYear = "this.year"
    case yearsAgo = "years.ago"

    case ingredientsTitle = "ingredients.title"
    case directionsTitle = "directions.title"
    case lastModifiedTitle = "last.modified.title"

    public var localized: String {
        rawValue.localize(bundle: .module)
    }

}
