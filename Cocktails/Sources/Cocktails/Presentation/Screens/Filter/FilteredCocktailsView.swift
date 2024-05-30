import SwiftUI
import Kingfisher
import CoreUI

struct FilteredCocktailsView: View {

    @StateObject var viewModel: FilterViewModel

    var body: some View {
        NavigationStack {
            CocktailListView(listItems: viewModel.filteredCocktails)
                .navigationTitle(
                    String(describing: viewModel.$filteredCocktails.count)
                        .appending(LocalizableStrings.filteredResult.localized))
        }
    }

}

#Preview {

    FilteredCocktailsView(viewModel: FilterViewModel())

}
