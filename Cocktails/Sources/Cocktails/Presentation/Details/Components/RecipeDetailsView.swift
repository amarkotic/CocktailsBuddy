import SwiftUI
import CoreUI

struct RecipeDetailsView: View {

    private var details: DetailsModel

    init(details: DetailsModel) {
        self.details = details
    }

    public var body: some View {
        VStack {
            headerView(model: details)
                .padding(.top, 24)
                .padding(.horizontal, 32)

            HorizontalDivider()
                .padding(.vertical, 16)

            contentView(model: details)
                .padding(.horizontal, 24)
        }
        .padding(.bottom, 40)
        .background(Color.white)
    }

    // TODO: - replace mocked images with assets
    func headerView(model: DetailsModel) -> some View {
        HStack {
            iconView(image: Image.category, title: model.category)

            Spacer()

            iconView(image: Image.glass, title: model.glass)

            Spacer()

            iconView(image: Image.alcoholic, title: model.alcoholicType)
        }
    }

    func contentView(model: DetailsModel) -> some View {
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
                    .frame(width: 48, height: 48)
                    .background(Color.white)

                Text(title)
                    .font(.subheadline)
            }
        }
    }

    @ViewBuilder
    func ingredientsView(_ ingredients: [String]) -> some View {
        MainSectionView(
            headerLabel: LocalizableStrings.ingredientsTitle.localized,
            compositionType: .vertical(alignment: .leading)) {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(ingredients, id: \.self) { ingredient in
                        Text("• \(ingredient)")
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
                }
        }
    }

}

#Preview {

    ScrollView {
        RecipeDetailsView(details: DetailsModel.mock)
    }

}
