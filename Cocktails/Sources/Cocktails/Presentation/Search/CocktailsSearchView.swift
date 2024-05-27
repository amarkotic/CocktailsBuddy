import SwiftUI
import Kingfisher
import CoreUI

struct CocktailsSearchView: View {

    @StateObject var viewModel: CocktailsSearchViewModel

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack {
                    searchHeaderView

                    CocktailListView(viewModel: viewModel.items, query: viewModel.query)
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

            NavigationLink(destination: FilterView()) {
                if viewModel.query.isEmpty {
                    Image.filter
                        .resizable()
                        .frame(width: 32, height: 32)
                }
            }
        }
        .padding(.top, 8)
        .padding([.horizontal, .bottom], 16)
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

#Preview {

    CocktailsSearchView(viewModel: CocktailsSearchViewModel())

}
