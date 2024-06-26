import SwiftUI
import CoreUI

struct FiltersView: View {

    @StateObject var viewModel: FiltersViewModel

    var body: some View {
        switch viewModel.filters {
        case .loading:
            MainProgressView()
        case .success(let model):
            content(model)
        case .failure:
            NoResultView(result: .failure)
                .background(Color.primaryLightBlue)
        }
    }

    private func content(_ model: FiltersModel) -> some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                navigationBar

                filterSections(model)
            }

            searchButton
        }
        .background(Color.primaryWhite)
    }

    private var navigationBar: some View {
        NavigationBar {
            PrimaryNavBarContent(
                title: LocalizableStrings.filters.localized,
                leadingModel: NavBarButtonModel(action: viewModel.backTap, buttonContent: NavBarBackButton()),
                trailingModel: NavBarButtonModel(action: viewModel.resetFilters, buttonContent: resetButton))
        }
    }

    private func filterSections(_ model: FiltersModel) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                FilterSectionView(
                    headerLabel: LocalizableStrings.category.localized,
                    items: model.categoryFilterItems,
                    selectedItem: $viewModel.category
                )

                HorizontalDivider()

                FilterSectionView(
                    headerLabel: LocalizableStrings.glass.localized,
                    items: model.glassFilterItems,
                    selectedItem: $viewModel.glass
                )

                HorizontalDivider()

                FilterSectionView(
                    headerLabel: LocalizableStrings.alcohol.localized,
                    items: model.alcoholicFilterItems,
                    selectedItem: $viewModel.alcohol
                )
            }
            .padding([.top, .horizontal], 24)
            .padding(.bottom, 60)
        }
    }

    private var searchButton: some View {
        PrimaryButton(title: LocalizableStrings.search.localized.uppercased(), isEnabled: viewModel.anyFilterSelected) {
            viewModel.showFilteredResults()
        }
        .padding(.horizontal, 24)
    }

    private var resetButton: some View {
        Text(LocalizableStrings.reset.localized.uppercased())
            .font(.headerSecondary)
            .foregroundStyle(Color.primaryLightBlue.opacity(viewModel.anyFilterSelected ? 1 : 0.2))
    }

}

#Preview {

    return FiltersView(viewModel: FiltersViewModel(coordinator: CocktailsCoordinatorMock()))

}
