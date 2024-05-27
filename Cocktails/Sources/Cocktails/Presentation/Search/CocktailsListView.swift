import SwiftUI
import Kingfisher
import CoreUI

struct CocktailsListView: View {

    @StateObject var viewModel: CocktailsListViewModel

    public var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack {
                    searchHeaderView

                    listView
                }

                feelingLuckyButton
            }
            .background(Color.blue)
        }
    }

    @ViewBuilder
    private var searchHeaderView: some View {
        HStack(spacing: 16) {
            SearchBarView(query: $viewModel.query)

            NavigationLink(destination: FilterView(viewModel: FilterViewModel())) {
                if viewModel.query.isEmpty {
                    Image.filter
                        .resizable()
                        .frame(width: 32, height: 32)
                }
            }
        }
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
                CocktailSearchCardView(model: item)
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

    @ViewBuilder
    private var feelingLuckyButton: some View {
        NavigationLink(destination: DetailsView(viewModel: DetailsViewModel(id: nil))) {
            Text(LocalizableStrings.feelingLucky.localized.uppercased())
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
                .padding(.horizontal, 40)
                .padding(.vertical, 16)
                .background(Color.blue)
                .cornerRadius(16)
        }
    }

}
