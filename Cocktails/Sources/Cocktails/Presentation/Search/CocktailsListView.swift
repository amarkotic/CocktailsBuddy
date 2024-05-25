import SwiftUI
import Kingfisher
import CoreUI

struct CocktailsListView: View {

    @StateObject var viewModel: CocktailsListViewModel

    public var body: some View {
        NavigationStack {
            VStack {
                searchHeaderView

                listView
            }
            .background(Color.blue)
        }
    }

    @ViewBuilder
    private var searchHeaderView: some View {
        SearchBarView(query: $viewModel.query)
            .padding([.horizontal, .top], 16)
    }

    @ViewBuilder
    private var listView: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                if !viewModel.items.isEmpty {
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
        ForEach(viewModel.items) { item in
            NavigationLink(destination: DetailsView(viewModel: DetailsViewModel(id: item.id))) {
                CocktailCardView(model: item)
            }
            .buttonStyle(PlainButtonStyle())

            HorizontalDivider()
        }
    }

    @ViewBuilder
    private var searchNoResultsView: some View {
        if !viewModel.query.isEmpty {
            VStack(spacing: 16) {
                Image.searchCancel
                    .resizable()
                    .frame(width: 40, height: 40)

                Text(String(format: LocalizableStrings.noSearchResult.localized, viewModel.query))
                    .font(.body)
                    .multilineTextAlignment(.center)
            }
            .padding(.all, 16)
            .padding(.top, 16)
        }
    }

}
