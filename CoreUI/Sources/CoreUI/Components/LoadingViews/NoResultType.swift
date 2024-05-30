import SwiftUI

public enum NoResultType {

    case empty
    case failure

    var icon: Image {
        switch self {
        case .empty:
            .searchCancel
        case .failure:
            .searchCancel
        }
    }

    var title: String {
        switch self {
        case .empty:
            LocalizableStrings.noResult.localized
        case .failure:
            LocalizableStrings.failureDescription.localized
        }
    }

}
