import SwiftUI
import CoreUI

struct DetailsView: View {

    @StateObject var viewModel: DetailsViewModel

    private let defaultImageHeight: CGFloat = DeviceType.isMobile ? 480 : 600

    public var body: some View {
        switch viewModel.details {
        case .loading:
            MainProgressView()
        case .success(let model):
            cocktailDetails(model)
        case .failure:
            NoResultView(result: .failure)
        }
    }

    @ViewBuilder
    private func cocktailDetails(_ model: CocktailModel) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                ParallaxImageView(imageUrl: model.url, defaultHeight: defaultImageHeight)

                RecipeDetailsView(details: model)
                    .cornerRadius(40)
                    .offset(y: -60)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .background(Color.primaryLightBlue)
    }

}

#Preview {

    DetailsView(viewModel: DetailsViewModel.init(id: "11000"))

}
