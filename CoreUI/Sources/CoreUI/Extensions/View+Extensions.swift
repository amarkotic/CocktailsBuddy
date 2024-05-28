import SwiftUI

// MARK: Dimensions
public extension View {

    func maxWidth(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }

    func maxHeight(alignment: Alignment = .center) -> some View {
        frame(maxHeight: .infinity, alignment: alignment)
    }

}

// MARK: Hide keyboard
public extension View {

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    func onTapHideKeyboard() -> some View {
        onTapGesture { hideKeyboard() }
    }

}

// MARK: Border any view
public extension View {

    func border(cornerRadius: CGFloat = 4, color: Color = .divider, lineWidth: CGFloat = 1) -> some View {
        overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(color, lineWidth: lineWidth)
                .padding(lineWidth / 2)
        }
        .cornerRadius(cornerRadius)
    }

}
