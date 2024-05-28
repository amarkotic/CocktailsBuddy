import SwiftUI
import CoreUI

struct CocktailListView: View {

    var listItems: [CocktailSearchCardModel]
    var query: String?

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                if !listItems.isEmpty {
                    searchResultsView
                } else {
                    searchNoResultsView
                }
            }
        }
        .padding(.horizontal, 24)
        .background(Color.primaryLightBlue)
    }

    private var searchResultsView: some View {
        ForEach(listItems) { item in
            NavigationLink(destination: DetailsView(viewModel: DetailsViewModel(id: item.id))) {
                CocktailSearchCardView(model: item)
            }
            .buttonStyle(PlainButtonStyle())

            if !item.isLastItem {
                HorizontalDivider()
            }
        }
    }

    @ViewBuilder
    private var searchNoResultsView: some View {
        if let query, !query.isEmpty {
            VStack(spacing: 16) {
                Image.searchCancel
                    .resizable()
                    .frame(width: 40, height: 40)

                Text(String(format: LocalizableStrings.noSearchResult.localized, query))
                    .font(.bodyPrimary)
                    .foregroundStyle(Color.secondaryBlack)
                    .multilineTextAlignment(.center)
            }
            .padding(.all, 16)
            .padding(.top, 16)
        }
    }

}

#Preview {

    NavigationStack {
        CocktailListView(listItems: [], query: "f")
    }

}
