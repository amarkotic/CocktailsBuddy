import SwiftUI
import Kingfisher
import CoreUI

struct CocktailsSearchView: View {

    @StateObject var viewModel: CocktailsSearchViewModel
    @FocusState private var searchFocused: Bool

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                searchCocktailsView

                feelingLuckyButton
            }
            .background(Color.primaryLightBlue)
            .ignoresSafeArea(.keyboard)
            .onTapHideKeyboard()
        }
    }

    private var searchCocktailsView: some View {
        VStack(spacing: 0) {
            searchHeaderView
                .background(Color.primaryBlue)

            CocktailListView(listItems: viewModel.items)
                .maxSize(alignment: .top)
        }
    }

    private var searchHeaderView: some View {
        HStack(spacing: 16) {
            SearchBarView(query: $viewModel.query)
                .focused($searchFocused)

            NavigationLink(destination: FilterView()) {
                if viewModel.query.isEmpty {
                    Image.filter
                        .resizable()
                        .frame(width: 32, height: 32)
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }

    private var feelingLuckyButton: some View {
        NavigationLink(destination: DetailsView(viewModel: DetailsViewModel(id: nil))) {
            PrimaryButton(title: LocalizableStrings.feelingLucky.localized.uppercased())
                .padding(.horizontal, 80)
        }
    }

}

#Preview {

    CocktailsSearchView(viewModel: CocktailsSearchViewModel())

}
