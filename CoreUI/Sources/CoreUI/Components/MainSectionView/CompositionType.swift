import SwiftUI
import Foundation

public enum CompositionType {

    case vertical(alignment: HorizontalAlignment, spacing: CGFloat)
    case horizontal(alignment: VerticalAlignment, spacing: CGFloat)

}
