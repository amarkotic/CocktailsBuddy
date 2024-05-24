import SwiftUI

public struct CocktailsView: View {

    public init() {}

    public var body: some View {
        DetailsView(viewModel: DetailsViewModel())
    }

}
