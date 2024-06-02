import SwiftUI

public struct PrimaryButton: View {

    private let title: String
    private let height: CGFloat
    private let isEnabled: Bool
    private let action: (() -> Void)?

    public init(title: String, height: CGFloat = 50, isEnabled: Bool = true, action: (() -> Void)? = nil) {
        self.title = title
        self.height = height
        self.action = action
        self.isEnabled = isEnabled
    }

    public var body: some View {
        if let action = action {
            Button(action: action) {
                buttonContent
            }
            .disabled(!isEnabled)
        } else {
            buttonContent
        }
    }

    private var buttonContent: some View {
        Text(title)
            .font(.headerPrimary)
            .foregroundStyle(Color.primaryWhite)
            .padding(.horizontal, 40)
            .frame(height: height)
            .maxWidth()
            .background(isEnabled ? Color.primaryBlue : Color.secondaryBlue)
            .cornerRadius(height / 2)
            .disabled(!isEnabled)
    }

}

#Preview {

    VStack(spacing: 8) {
        PrimaryButton(title: "Feeling lucky", isEnabled: false)
        PrimaryButton(title: "Feeling lucky", isEnabled: true)
    }
    .padding(.horizontal, 16)

}
