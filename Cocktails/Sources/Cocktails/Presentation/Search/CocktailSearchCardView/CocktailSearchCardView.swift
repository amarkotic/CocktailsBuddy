import SwiftUI
import Kingfisher

struct CocktailSearchCardView: View {

    var model: CocktailSearchCardModel

    var body: some View {
        HStack(spacing: 16) {
            cocktailImage

            cocktailDetails
        }
        .maxWidth(alignment: .leading)
        .padding(.vertical, 12)
    }

    @ViewBuilder
    private var cocktailImage: some View {
        KFImage(model.url)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 60, height: 80)
            .cornerRadius(16)
    }

    @ViewBuilder
    private var cocktailDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model.title)
                .font(.subheadline)
                .fontWeight(.bold)
                .lineLimit(1)

            Text(model.description)
                .font(.caption2)
                .lineLimit(1)
        }
    }

}

#Preview {

    ScrollView {
        LazyVStack {
            CocktailSearchCardView(model: CocktailSearchCardModel.mock)
            CocktailSearchCardView(model: CocktailSearchCardModel.mock)
            CocktailSearchCardView(model: CocktailSearchCardModel.mock)
            CocktailSearchCardView(model: CocktailSearchCardModel.mock)
        }
    }
    .padding()

}
