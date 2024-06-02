import SwiftUI
import Kingfisher
import CoreUI

struct CocktailsSearchView: View {

    @StateObject var viewModel: CocktailsSearchViewModel

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
            navigationBar

            CocktailsListView(listItems: viewModel.items) { selectedId in
                viewModel.selectCocktail(selectedId)
            }
        }
    }

    private var navigationBar: some View {
        NavigationBar {
            searchHeaderView
                .disabled(viewModel.items == .failure)
        }
    }

    private var searchHeaderView: some View {
        HStack(spacing: 16) {
            SearchBarView(query: $viewModel.query)

            if viewModel.query.isEmpty {
                Image.filter
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        viewModel.openFilters()
                    }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }

    private var feelingLuckyButton: some View {
        PrimaryButton(title: LocalizableStrings.feelingLucky.localized.uppercased()) {
            viewModel.selectCocktail(nil)
        }
        .padding(.horizontal, 80)
    }

}

#Preview {

    CocktailsSearchView(viewModel: CocktailsSearchViewModel(coordinator: CocktailsCoordinatorMock()))

}
