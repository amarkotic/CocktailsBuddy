import SwiftUI
import Kingfisher
import CoreUI

struct FilteredCocktailsView: View {

    @StateObject var viewModel: FilteredCocktailsViewModel

    var body: some View {
        VStack(spacing: 0) {
            navigationBar

            CocktailsListView(listItems: viewModel.filteredCocktails) { cocktailID in
                viewModel.selectCocktail(cocktailID)
            }
        }
    }

    @ViewBuilder
    private var navigationBar: some View {
        if case .success(let model) = viewModel.filteredCocktails {
            NavigationBar {
                PrimaryNavBarContent(
                    title: String(format: LocalizableStrings.filteredResult.localized, String(model.count)),
                    leadingModel: NavBarButtonModel(action: viewModel.backTap, buttonContent: NavBarBackButton()))
            }
        }
    }

}

#Preview {

    FilteredCocktailsView(
        viewModel: FilteredCocktailsViewModel(
            coordinator: CocktailsCoordinatorMock(),
            appliedFilters: AppliedFiltersModel(alcohol: "Alcoholic", category: nil, glass: nil)))

}
