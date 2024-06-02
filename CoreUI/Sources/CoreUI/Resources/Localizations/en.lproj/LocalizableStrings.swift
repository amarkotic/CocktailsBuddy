public enum LocalizableStrings: String, Localizable {

    case searchBarPlaceholder = "search.bar.placeholder"
    case noResult = "no.result"
    case failureDescription = "failure.description"
    case colon

    public var localized: String {
        rawValue.localize(bundle: .module)
    }

}
