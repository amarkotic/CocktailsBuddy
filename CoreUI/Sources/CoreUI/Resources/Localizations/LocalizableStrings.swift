public enum LocalizableStrings: String, Localizable {

    case searchBarPlaceholder = "search.bar.placeholder"

    public var localized: String {
        rawValue.localize(bundle: .module)
    }

}
