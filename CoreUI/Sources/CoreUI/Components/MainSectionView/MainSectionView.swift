import SwiftUI

public struct MainSectionView<Content: View>: View {

    private let headerLabel: String
    private let compositionType: CompositionType
    private let content: Content

    public init(headerLabel: String, compositionType: CompositionType, @ViewBuilder content: () -> Content) {
        self.headerLabel = headerLabel
        self.compositionType = compositionType
        self.content = content()
    }

    public var body: some View {
        switch compositionType {
        case .horizontal(let alignment, let spacing):
            horizontalContent(alignment: alignment, spacing: spacing)
        case .vertical(let alignment, let spacing):
            verticalContent(alignment: alignment, spacing: spacing)
        }
    }

    private func horizontalContent(alignment: VerticalAlignment, spacing: CGFloat) -> some View {
        HStack(alignment: alignment, spacing: spacing) {
            header

            content
        }
    }

    private func verticalContent(alignment: HorizontalAlignment, spacing: CGFloat) -> some View {
        VStack(alignment: alignment, spacing: spacing) {
            header

            content
        }
    }

    private var header: some View {
        Text(headerLabel.appending(LocalizableStrings.colon.localized))
            .font(.headerSecondary)
            .foregroundStyle(Color.primaryBlack)
    }

}

#Preview {

    let items = VStack {
        Text("Lorem ipsum")

        Text("Lorem ipsum")

        Text("Lorem ipsum")
    }

    let verticalSection = MainSectionView(
        headerLabel: "Description",
        compositionType: .vertical(alignment: .leading, spacing: 8)
    ) {
        items
    }

    let horizontalSection = MainSectionView(
        headerLabel: "Description",
        compositionType: .horizontal(alignment: .top, spacing: 8)
    ) {
        items
    }

    return VStack(spacing: 40) {
        verticalSection

        horizontalSection
    }
    .padding(.horizontal, 16)

}
