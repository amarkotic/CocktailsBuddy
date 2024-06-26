import SwiftUI
import Kingfisher

struct ParallaxImageView: View {

    private let imageUrl: URL?
    private let defaultHeight: CGFloat

    init(imageUrl: URL?, defaultHeight: CGFloat) {
        self.imageUrl = imageUrl
        self.defaultHeight = defaultHeight
    }

    public var body: some View {
        GeometryReader { proxy in
            if proxy.frame(in: .global).minY > -defaultHeight {
                KFImage(imageUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -proxy.frame(in: .global).minY)
                    .frame(
                        width: proxy.size.width,
                        height: proxy.frame(in: .global).minY > 0 ?
                        proxy.frame(in: .global).minY + defaultHeight :
                            defaultHeight)
            }
        }
        .frame(height: defaultHeight)
    }

}

#Preview {

    ScrollView {
        let url = CocktailModel.mock.url
        let defaultHeight: CGFloat = 480

        return ParallaxImageView(imageUrl: url, defaultHeight: defaultHeight)
    }

}
