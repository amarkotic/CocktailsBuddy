import SwiftUI
import Kingfisher

struct CocktailCardView: View {

    var model: CocktailCardModel
    var action: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            cocktailImage

            cocktailDetails
        }
        .maxWidth(alignment: .leading)
        .padding(.vertical, 12)
        .background(Color.primaryLightBlue)
        .contentShape(Rectangle())
        .onTapGesture {
            action()
        }
    }

    private var cocktailImage: some View {
        KFImage(model.url)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 60, height: 80)
            .cornerRadius(16)
    }

    private var cocktailDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model.title)
                .font(.headerSecondary)
                .foregroundStyle(Color.primaryBlack)
                .lineLimit(1)

            if !model.description.isEmpty {
                Text(model.description)
                    .font(.bodySecondary)
                    .foregroundStyle(Color.secondaryBlack)
                    .lineLimit(1)
            }
        }
    }

}

#Preview {

    ScrollView {
        LazyVStack {
            CocktailCardView(model: CocktailCardModel.mock) { }
            CocktailCardView(model: CocktailCardModel.mock) { }
            CocktailCardView(model: CocktailCardModel.mock) { }
            CocktailCardView(model: CocktailCardModel.mock) { }
        }
    }
    .padding()

}
