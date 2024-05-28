import SwiftUI
import CoreUI

struct DetailsView: View {

    @StateObject var viewModel: DetailsViewModel

    private let defaultImageHeight: CGFloat = DeviceType.isMobile ? 480 : 600

    public var body: some View {
        ScrollView(showsIndicators: false) {
            cocktailDetails
        }
        .background(Color.primaryLightBlue)
        .onAppear {
            viewModel.fetchDetails()
        }
    }

    @ViewBuilder
    private var cocktailDetails: some View {
        if let details = viewModel.details {
            VStack(alignment: .leading) {
                ParallaxImageView(imageUrl: details.url, defaultHeight: defaultImageHeight)

                RecipeDetailsView(details: details)
                    .cornerRadius(40)
                    .offset(y: -60)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }

}

#Preview {

    DetailsView(viewModel: DetailsViewModel.init(id: "11000"))

}
