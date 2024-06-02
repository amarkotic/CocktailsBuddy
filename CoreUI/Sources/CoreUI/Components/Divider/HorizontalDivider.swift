import SwiftUI

public struct HorizontalDivider: View {

    private let color: Color
    private let height: CGFloat

    public init(color: Color = .divider, height: CGFloat = 1.0) {
        self.color = color
        self.height = height
    }

    public var body: some View {
        Rectangle()
            .foregroundColor(color)
            .frame(height: height)
            .opacity(0.7)
    }

}

#Preview {

    HorizontalDivider()

}
