import SwiftUI

public struct SearchBarView: View {

    @Binding private var query: String

    public init(query: Binding<String>) {
        self._query = query
    }

    public var body: some View {
        HStack {
            Image.search

            TextField(LocalizableStrings.searchBarPlaceholder.localized, text: $query)
                .textFieldStyle(PlainTextFieldStyle())
                .frame(height: 40)

            if !query.isEmpty {
                cancelButton
            }
        }
        .padding(.horizontal, 12)
        .frame(height: 40)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }

    @ViewBuilder
    private var cancelButton: some View {
        Button {
            cancelTapped()
        } label: {
            Image.searchCancel
                .frame(width: 16, height: 16)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
    }

    private func cancelTapped() {
        query.removeAll()
    }

}
