import SwiftUI

public struct MainSectionView<Content: View>: View {

    private var headerLabel: String
    private var compositionType: CompositionType
    private var content: Content

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

    func horizontalContent(alignment: VerticalAlignment, spacing: CGFloat) -> some View {
        HStack(alignment: alignment, spacing: spacing) {
            header

            content
        }
    }

    func verticalContent(alignment: HorizontalAlignment, spacing: CGFloat) -> some View {
        VStack(alignment: alignment, spacing: spacing) {
            header

            content
        }
    }

    var header: some View {
        Text(headerLabel)
            .font(.headline)
            .foregroundStyle(Color.black)
    }

}
