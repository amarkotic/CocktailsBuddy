public enum LocalizableStrings: String, Localizable {

    case searchBarPlaceholder = "search.bar.placeholder"
    case colon

    public var localized: String {
        rawValue.localize(bundle: .module)
    }

}
