import SwiftUI
import CoreUI

struct CocktailDetailsView: View {

    @StateObject var viewModel: CocktailDetailsViewModel

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

    private func navigationBar(title: String) -> some View {
        NavigationBar {
            PrimaryNavBarContent(
                title: title,
                leadingModel: NavBarButtonModel(action: viewModel.backTap, buttonContent: NavBarBackButton())
            )
        }
    }

    private func cocktailDetails(_ model: CocktailModel) -> some View {
        VStack(spacing: 0) {
            navigationBar(title: model.name)

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

}

#Preview {

    CocktailDetailsView(viewModel: CocktailDetailsViewModel(coordinator: .mock, id: "11000"))

}
