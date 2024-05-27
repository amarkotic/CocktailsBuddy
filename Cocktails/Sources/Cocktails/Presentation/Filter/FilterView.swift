import SwiftUI
import CoreUI

struct FilterView: View {

    @ObservedObject var viewModel = FilterViewModel()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                categorySection

                HorizontalDivider()

                glassSection

                HorizontalDivider()

                alcoholSection
            }
        }
        .padding(24)
        .onAppear {
            viewModel.fetchFilters()
        }
    }

    @ViewBuilder
    private var categorySection: some View {
        MainSectionView(
            headerLabel: LocalizableStrings.category.localized,
            compositionType: .vertical(alignment: .leading)) {
                VStack(spacing: 16) {
                    ForEach(viewModel.filterModel.alcoholicFilterItems, id: \.self) { item in
                        RadioButton(title: item, isSelected: viewModel.selectedCategory == item) {
                            viewModel.selectedCategory = item
                        }
                    }
                }
            }
    }

    @ViewBuilder
    private var glassSection: some View {
        MainSectionView(
            headerLabel: LocalizableStrings.glass.localized,
            compositionType: .vertical(alignment: .leading)) {
                VStack(spacing: 16) {
                    ForEach(viewModel.filterModel.glassFilterItems, id: \.self) { item in
                        RadioButton(title: item, isSelected: viewModel.selectedGlass == item) {
                            viewModel.selectedGlass = item
                        }
                    }
                }
            }
    }

    @ViewBuilder
    private var alcoholSection: some View {
        MainSectionView(
            headerLabel: LocalizableStrings.alcohol.localized,
            compositionType: .vertical(alignment: .leading)) {
                VStack(spacing: 16) {
                    ForEach(viewModel.filterModel.categoryFilterItems, id: \.self) { item in
                        RadioButton(title: item, isSelected: viewModel.selectedAlcohol == item) {
                            viewModel.selectedAlcohol = item
                        }
                    }
                }
            }
    }

}

#Preview {

    FilterView()

}
