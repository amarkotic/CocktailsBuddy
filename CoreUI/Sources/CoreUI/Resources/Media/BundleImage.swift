import SwiftUI

public enum BundleImage: String {

    case search
    case searchCancel
    case radioButton
    case radioButtonSelected

    public var image: Image {
        Image(self.rawValue, bundle: .module)
    }

}
