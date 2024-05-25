import SwiftUI

public struct CocktailsView: View {

    public init() {}

    public var body: some View {
        CocktailsListView(viewModel: CocktailsListViewModel())
    }

}
