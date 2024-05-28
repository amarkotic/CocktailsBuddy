import SwiftUI

public struct SearchBarView: View {

    @Binding private var query: String

    public init(query: Binding<String>) {
        self._query = query
    }

    public var body: some View {
        HStack(spacing: 8) {
            magnifierImage

            textField

            cancelButton
        }
        .padding(.horizontal, 12)
        .frame(height: 40)
        .background(Color.primaryWhite)
        .cornerRadius(8)
    }

    private var magnifierImage: some View {
        Image.search
    }

    private var textField: some View {
        TextField(
            "",
            text: $query,
            prompt: Text(LocalizableStrings.searchBarPlaceholder.localized)
                .foregroundStyle(Color.secondaryBlack.opacity(0.5)))
        .foregroundStyle(Color.secondaryBlack)
        .maxHeight()
    }

    @ViewBuilder
    private var cancelButton: some View {
        if !query.isEmpty {
            Button {
                cancelTapped()
            } label: {
                Image.searchCancel
                    .frame(width: 16, height: 16)
                    .background(Color.primaryGray)
                    .cornerRadius(8)
            }
        }
    }

    private func cancelTapped() {
        query.removeAll()
    }

}

#Preview {

    @State var query1 = ""
    @State var query2 = "Search text"

    return VStack {
        SearchBarView(query: $query1)

        SearchBarView(query: $query2)
    }

}
