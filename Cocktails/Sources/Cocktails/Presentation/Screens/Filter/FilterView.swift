import SwiftUI
import CoreUI

struct FilterView: View {

    @StateObject var viewModel = FilterViewModel()
    @State private var showFilteredResults = false

    var body: some View {
        ZStack(alignment: .bottom) {
            filterSections

            searchButton
        }
        .toolbar {
            resetButton
        }
        .background(Color.primaryWhite)
        .background(
            NavigationLink(destination: FilteredCocktailsView(viewModel: viewModel), isActive: $showFilteredResults) {
                EmptyView()
            }
        )
    }

    private var filterSections: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                categorySection

                HorizontalDivider()

                glassSection

                HorizontalDivider()

                alcoholSection
            }
            .padding([.top, .horizontal], 24)
            .padding(.bottom, 60)
        }
    }

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
        PrimaryButton(
            title: LocalizableStrings.search.localized.uppercased(),
            isEnabled: viewModel.anyFilterSelected
        ) {
            viewModel.search {
                showFilteredResults = true
            }
        }
        .padding(.horizontal, 24)
    }

    private var resetButton: some View {
        Button {
            viewModel.resetFilters()
        } label: {
            Text(LocalizableStrings.reset.localized.uppercased())
                .font(.headerSecondary)
                .foregroundStyle(viewModel.anyFilterSelected ? Color.primaryBlue : Color.primaryGray)
        }
        .disabled(!viewModel.anyFilterSelected)
    }

}

#Preview {

    NavigationStack {
        FilterView()
    }

}
