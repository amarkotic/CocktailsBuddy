import SwiftUI

public struct RadioButton: View {

    private let title: String
    private let isSelected: Bool
    private let callback: () -> Void

    public init(title: String, isSelected: Bool, callback: @escaping () -> Void) {
        self.title = title
        self.isSelected = isSelected
        self.callback = callback
    }

    public var body: some View {
        Button {
            callback()
        } label: {
            HStack(spacing: 8) {
                if isSelected {
                    Image.radioButtonSelected
                } else {
                    Image.radioButton
                }

                Text(title)
                    .font(.bodyPrimary)
                    .foregroundStyle(Color.secondaryBlack)
            }
            .maxWidth(alignment: .leading)
            .foregroundColor(.primaryBlack)
        }
        .contentShape(Rectangle())
    }

}

#Preview {

    VStack {
        RadioButton(title: "Alcoholic", isSelected: true) { }

        RadioButton(title: "Non alcoholic", isSelected: false) { }
    }

}
