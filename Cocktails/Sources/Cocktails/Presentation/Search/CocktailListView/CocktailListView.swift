import SwiftUI
import CoreUI

struct CocktailListView: View {

    var viewModel: [CocktailSearchCardModel]
    var query: String?

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                if !viewModel.isEmpty {
                    searchResultsView
                } else {
                    searchNoResultsView
                }
            }
        }
        .padding(.horizontal, 24)
        .background(Color.white)
    }

    @ViewBuilder
    private var searchResultsView: some View {
        ForEach(viewModel) { item in
            NavigationLink(destination: DetailsView(viewModel: DetailsViewModel(id: item.id))) {
                CocktailSearchCardView(model: item)
            }
            .buttonStyle(PlainButtonStyle())

            HorizontalDivider()
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
                    .font(.body)
                    .multilineTextAlignment(.center)
            }
            .padding(.all, 16)
            .padding(.top, 16)
        }
    }

}
