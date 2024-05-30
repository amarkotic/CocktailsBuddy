import SwiftUI

// Default back button for navigation bar
public struct NavBarBackButton: View {

    public init() {}

    public var body: some View {
        Image.back
            .resizable()
            .frame(width: 16, height: 28)
            .aspectRatio(contentMode: .fill)
    }

}
