import SwiftUI

public enum BundleImage: String {

    case alcoholic
    case category
    case glass

    public var image: Image {
        Image(self.rawValue, bundle: .module)
    }

}
