import SwiftUI
import Foundation

public enum CompositionType {

    case vertical(alignment: HorizontalAlignment = .center, spacing: CGFloat = 16)
    case horizontal(alignment: VerticalAlignment = .center, spacing: CGFloat = 8)

}
