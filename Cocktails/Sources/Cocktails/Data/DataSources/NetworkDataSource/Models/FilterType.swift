enum FilterType: String {

    case alcohol
    case category
    case glass

    var queryKey: String {
        switch self {
        case .alcohol:
            "a"
        case .category:
            "c"
        case .glass:
            "g"
        }
    }

}
