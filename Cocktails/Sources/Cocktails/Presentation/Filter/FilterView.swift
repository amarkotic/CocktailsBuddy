import SwiftUI
import CoreUI

struct FilterView: View {

    @StateObject var viewModel = FilterViewModel()
    @State private var showFilteredResults = false

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    categorySection

                    HorizontalDivider()

                    glassSection

                    HorizontalDivider()

                    alcoholSection
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 24)

            searchButton
        }
        .toolbar {
            resetButton
        }
        .background(
            NavigationLink(destination: FilteredCocktailsView(viewModel: viewModel), isActive: $showFilteredResults) {
                EmptyView()
            }
        )
    }

    @ViewBuilder
    private var categorySection: some View {
        MainSectionView(
            headerLabel: LocalizableStrings.category.localized,
            compositionType: .vertical(alignment: .leading)) {
                VStack(spacing: 16) {
                    ForEach(viewModel.filters.categoryFilterItems, id: \.self) { item in
                        RadioButton(title: item, isSelected: viewModel.appliedFilters.category == item) {
                            viewModel.appliedFilters.category = item
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
                    ForEach(viewModel.filters.glassFilterItems, id: \.self) { item in
                        RadioButton(title: item, isSelected: viewModel.appliedFilters.glass == item) {
                            viewModel.appliedFilters.glass = item
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
                    ForEach(viewModel.filters.alcoholicFilterItems, id: \.self) { item in
                        RadioButton(title: item, isSelected: viewModel.appliedFilters.alcohol == item) {
                            viewModel.appliedFilters.alcohol = item
                        }
                    }
                }
            }
    }

    private var searchButton: some View {
        Button {
            viewModel.search {
                showFilteredResults = true
            }
        } label: {
            Text(LocalizableStrings.search.localized.uppercased())
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
                .padding(.horizontal, 40)
                .padding(.vertical, 16)
                .background(viewModel.anyFilterSelected ? Color.blue : Color.gray)
                .cornerRadius(16)
        }
        .disabled(!viewModel.anyFilterSelected)
    }

    private var resetButton: some View {
        Button {
            viewModel.resetFilters()
        } label: {
            Text(LocalizableStrings.reset.localized.uppercased())
                .foregroundStyle(viewModel.anyFilterSelected ? Color.blue : Color.gray)
        }
        .disabled(!viewModel.anyFilterSelected)
    }

}

#Preview {

    FilterView()

}
