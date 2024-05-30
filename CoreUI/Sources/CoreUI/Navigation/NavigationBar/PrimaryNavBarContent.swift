import SwiftUI

public struct PrimaryNavBarContent: View {

    var title: String?
    var leadingModel: NavBarButtonModel?
    var trailingModel: NavBarButtonModel?

    public init(title: String? = nil, leadingModel: NavBarButtonModel? = nil, trailingModel: NavBarButtonModel? = nil) {
        self.title = title
        self.leadingModel = leadingModel
        self.trailingModel = trailingModel
    }

    public var body: some View {
        ZStack {
            if let title {
                Text(title)
                    .font(.headerPrimary)
                    .foregroundStyle(Color.primaryWhite)
            }

            HStack(spacing: 16) {
                barButton(leadingModel)

                Spacer()

                barButton(trailingModel)
            }
        }
    }

    @ViewBuilder
    private func barButton(_ model: NavBarButtonModel?) -> some View {
        if let model {
            Button {
                model.action()
            } label: {
                model.buttonContent
            }
        } else {
            Spacer()
                .frame(width: 24)
        }
    }

}

#Preview {

    VStack(spacing: 20) {
        NavigationBar {
            PrimaryNavBarContent(
                title: "Cocktail",
                leadingModel: NavBarButtonModel(action: {}, buttonContent: NavBarBackButton()))
        }

        NavigationBar {
            PrimaryNavBarContent(
                leadingModel: NavBarButtonModel(action: {}, buttonContent: NavBarBackButton()))
        }

        NavigationBar {
            PrimaryNavBarContent(
                trailingModel: NavBarButtonModel(action: {}, buttonContent: NavBarBackButton()))
        }

        NavigationBar {
            PrimaryNavBarContent(
                leadingModel: NavBarButtonModel(action: {}, buttonContent: NavBarBackButton()),
            trailingModel: NavBarButtonModel(action: {}, buttonContent: NavBarBackButton()))
        }

        NavigationBar {
            PrimaryNavBarContent(title: "Title")
        }

        @State var query1 = "Search text"

        NavigationBar {
            SearchBarView(query: $query1)
        }
    }

}
