import SwiftUI
import CoreUI

struct FilterSectionView: View {

    let headerLabel: String
    let items: [String]
    @Binding var selectedItem: String?

    var body: some View {
        MainSectionView(
            headerLabel: headerLabel,
            compositionType: .vertical(alignment: .leading)) {
                VStack(spacing: 16) {
                    ForEach(items, id: \.self) { item in
                        RadioButton(title: item, isSelected: selectedItem == item) {
                            selectedItem = item
                        }
                    }
                }
            }
    }

}
