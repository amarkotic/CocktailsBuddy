import SwiftUI
import Kingfisher

struct CocktailCardView: View {

    var model: CocktailCardModel

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

            Text(model.description)
                .font(.caption2)
        }
    }

}

#Preview {

    ScrollView {
        LazyVStack {
            CocktailCardView(model: CocktailCardModel.mock)
            CocktailCardView(model: CocktailCardModel.mock)
            CocktailCardView(model: CocktailCardModel.mock)
            CocktailCardView(model: CocktailCardModel.mock)
        }
    }
    .padding()

}
