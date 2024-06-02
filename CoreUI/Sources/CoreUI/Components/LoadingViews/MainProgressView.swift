import SwiftUI

public struct MainProgressView: View {

    private let tint: Color
    private let backgroundColor: Color

    public init(tint: Color = .primaryBlue, backgroundColor: Color = .primaryLightBlue) {
        self.tint = tint
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        ProgressView()
            .maxSize()
            .tint(tint)
            .background(backgroundColor)
    }

}

#Preview {

    MainProgressView()

}
