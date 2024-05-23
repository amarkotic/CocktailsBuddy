import SwiftUI

public struct HorizontalDivider: View {

    var color: Color
    var height: CGFloat

    public init(color: Color = .gray, height: CGFloat = 1.0) {
        self.color = color
        self.height = height
    }

    public var body: some View {
        Rectangle()
            .foregroundColor(color)
            .frame(height: height)
            .opacity(0.5)
    }

}

struct HorizontalDivider_Previews: PreviewProvider {

    static var previews: some View {
        HorizontalDivider()
    }

}
