import SwiftUI
import Core
import CoreUI

struct CocktailListView: View {

    var listItems: Result<[CocktailSearchCardModel]>

    var body: some View {
        switch listItems {
        case .loading:
            MainProgressView()
        case .success(let items):
            if items.isEmpty {
                NoResultView(result: .empty)
            } else {
                searchResultsView(items: items)
            }
        case .failure:
            NoResultView(result: .failure)
        }
    }

    private func searchResultsView(items: [CocktailSearchCardModel]) -> some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                ForEach(items) { item in
                    NavigationLink(destination: DetailsView(viewModel: DetailsViewModel(id: item.id))) {
                        CocktailSearchCardView(model: item)
                    }
                    .buttonStyle(PlainButtonStyle())

                    if !item.isLastItem {
                        HorizontalDivider()
                    }
                }
            }
        }
        .padding(.horizontal, 24)
        .background(Color.primaryLightBlue)
    }

}

#Preview {

    NavigationStack {
        CocktailListView(listItems: .loading)
    }

}
