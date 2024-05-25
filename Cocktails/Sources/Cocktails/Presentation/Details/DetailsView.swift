import SwiftUI
import Kingfisher
import CoreUI

struct DetailsView: View {

    @StateObject var viewModel: DetailsViewModel

    private let defaultImageHeight: CGFloat = DeviceType.isMobile ? 480 : 600

    public var body: some View {
        VStack(alignment: .leading) {
            if let details = viewModel.details {
                ScrollView {
                    ParallaxImageView(imageUrl: details.url, defaultHeight: defaultImageHeight)

                    RecipeDetailsView(details: details)
                        .cornerRadius(40)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            viewModel.fetchDetails()
        }
    }

}

#Preview {

    DetailsView(viewModel: DetailsViewModel.init(id: "11000"))

}
