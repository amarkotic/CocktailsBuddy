import SwiftUI
import Core
import CoreUI

struct CocktailsListView: View {

    var listItems: Result<[CocktailCardModel]>
    var cardSelected: (_ id: String) -> Void

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

    private func searchResultsView(items: [CocktailCardModel]) -> some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                ForEach(items) { item in
                    CocktailCardView(model: item) {
                        cardSelected(item.id)
                    }

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

    CocktailsListView(listItems: .success([CocktailCardModel.mock])) { _ in }

}
