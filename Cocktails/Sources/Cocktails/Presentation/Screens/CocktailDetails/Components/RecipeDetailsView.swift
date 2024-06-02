import SwiftUI
import CoreUI

struct RecipeDetailsView: View {

    private let details: CocktailModel

    init(details: CocktailModel) {
        self.details = details
    }

    public var body: some View {
        VStack(spacing: 16) {
            headerView(model: details)
                .padding(.top, 24)
                .padding(.horizontal, 32)

            HorizontalDivider()

            contentView(model: details)
                .padding(.horizontal, 24)
        }
        .padding(.bottom, 40)
        .background(Color.primaryLightBlue)
    }

    func headerView(model: CocktailModel) -> some View {
        HStack(spacing: 16) {
            iconView(image: Image.category, title: model.category)

            iconView(image: Image.glass, title: model.glass)

            iconView(image: Image.alcoholic, title: model.alcoholicType)
        }
    }

    func contentView(model: CocktailModel) -> some View {
        VStack(alignment: .leading, spacing: 24) {
            ingredientsView(details.ingredients)

            HorizontalDivider()

            directionsView(details.instructions)

            HorizontalDivider()

            historyView(details.lastModified)
        }
    }

    @ViewBuilder
    func iconView(image: Image, title: String?) -> some View {
        if let title {
            VStack(spacing: 12) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding(12)
                    .background(Color.primaryWhite)
                    .border(cornerRadius: 32, color: .divider.opacity(0.7))

                Text(title)
                    .font(.bodyPrimary)
                    .foregroundStyle(Color.secondaryBlack)
            }
            .maxWidth()
        }
    }

    func ingredientsView(_ ingredients: [String]) -> some View {
        MainSectionView(
            headerLabel: LocalizableStrings.ingredientsTitle.localized,
            compositionType: .vertical(alignment: .leading)) {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(ingredients, id: \.self) { ingredient in
                        Text("\(LocalizableStrings.dot.localized) \(ingredient)")
                            .font(.bodyPrimary)
                            .foregroundStyle(Color.secondaryBlack)
                    }
                }
            }
    }

    @ViewBuilder
    func directionsView(_ directions: String?) -> some View {
        if let directions {
            MainSectionView(
                headerLabel: LocalizableStrings.directionsTitle.localized,
                compositionType: .vertical(alignment: .leading)) {
                    Text(directions)
                        .font(.bodyPrimary)
                        .foregroundStyle(Color.secondaryBlack)
                }
        }
    }

    @ViewBuilder
    func historyView(_ lastModified: LastModified?) -> some View {
        if let lastModified {
            MainSectionView(
                headerLabel: LocalizableStrings.lastModifiedTitle.localized,
                compositionType: .horizontal(spacing: 4)) {
                    Text(lastModified.description)
                        .font(.bodyPrimary)
                        .foregroundStyle(Color.secondaryBlack)
                }
        }
    }

}

#Preview {

    ScrollView {
        RecipeDetailsView(details: CocktailModel.mock)
    }

}
