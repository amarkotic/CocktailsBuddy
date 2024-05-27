import SwiftUI

public enum BundleImage: String {

    case alcoholic
    case category
    case glass
    case filter

    public var image: Image {
        Image(self.rawValue, bundle: .module)
    }

}
