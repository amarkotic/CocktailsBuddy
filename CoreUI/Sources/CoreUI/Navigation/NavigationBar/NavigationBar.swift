import SwiftUI

// Primary navigation bar component introduced to keep consistent navBar across the app
// It takes any View as input, but PrimaryNavBarContent is designed to be used in most of the screens
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

#Preview {

    NavigationBar { PrimaryNavBarContent(
        title: "Cocktail",
        leadingModel: NavBarButtonModel(action: {}, buttonContent: NavBarBackButton()))
    }

}
