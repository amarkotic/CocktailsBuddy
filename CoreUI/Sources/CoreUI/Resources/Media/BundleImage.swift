import SwiftUI

public enum BundleImage: String {

    case search
    case searchCancel

    public var image: Image {
        Image(self.rawValue, bundle: .module)
    }

}
