import SwiftUI

public struct NavigationBar<Content: View>: View {

    private var content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        content
            .frame(height: 36)
            .maxWidth()
            .padding(.top, 8)
            .padding(.horizontal, 16)
            .padding(.bottom, 10)
            .background(Color.primaryBlue)
    }

}
