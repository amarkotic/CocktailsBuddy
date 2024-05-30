import SwiftUI

// Single navigation bar button model
public struct NavBarButtonModel {

    let action: () -> Void
    let buttonContent: AnyView

    public init(action: @escaping () -> Void, buttonContent: any View) {
        self.action = action
        self.buttonContent = AnyView(buttonContent)
    }

}
