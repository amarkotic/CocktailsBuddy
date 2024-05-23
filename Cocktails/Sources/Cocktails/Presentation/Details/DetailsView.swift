import SwiftUI
import Kingfisher
import CoreUI

public struct DetailsView: View {

    @StateObject private var viewModel: DetailsViewModel
    let defaultImageHeight: CGFloat = DeviceType.isMobile ? 480 : 600

    public init(viewModel: DetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

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
            viewModel.fetchDetails(id: "11000")
        }
    }

}
