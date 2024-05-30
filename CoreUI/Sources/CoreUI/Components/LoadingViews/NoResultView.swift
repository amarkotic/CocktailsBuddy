import SwiftUI

public struct NoResultView: View {

    private var result: NoResultType

    public init(result: NoResultType) {
        self.result = result
    }

    public var body: some View {
        VStack(spacing: 16) {
            result.icon
                .resizable()
                .frame(width: 40, height: 40)

            Text(result.title)
                .font(.bodyPrimary)
                .foregroundStyle(Color.secondaryBlack)
                .multilineTextAlignment(.center)
        }
        .maxHeight(alignment: .top)
        .maxWidth()
        .padding(.top, 32)
        .padding(.all, 16)
        .background(Color.primaryLightBlue)
    }

}

#Preview {

    VStack {
        NoResultView(result: .empty)
    }

}
