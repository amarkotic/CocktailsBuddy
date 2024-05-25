import SwiftUI

struct FilterView: View {

    @StateObject var viewModel: FilterViewModel

    public var body: some View {
        Text("Filter")
    }

}

#Preview {

    DetailsView(viewModel: DetailsViewModel.init(id: "11000"))

}
