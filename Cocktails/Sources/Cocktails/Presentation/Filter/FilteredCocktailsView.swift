import SwiftUI
import Kingfisher
import CoreUI

struct FilteredCocktailsView: View {

    @StateObject var viewModel: FilterViewModel

    var body: some View {
        NavigationStack {
            CocktailListView(viewModel: viewModel.filteredCocktails)
                .navigationTitle("\(viewModel.filteredCocktails.count) \(LocalizableStrings.filteredResult.localized)")
        }
    }

}

#Preview {

    FilteredCocktailsView(viewModel: FilterViewModel())

}
