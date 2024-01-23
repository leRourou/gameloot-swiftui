//
//  LootRow.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/23/24.
//

import SwiftUI

struct LootRow: View {
    public var item: LootItem
    var body: some View {
        NavigationLink {
            LootDetailView(item: item)
        } label: {
            HStack(alignment: .center, spacing: 3) {
                Image(systemName: "circle.fill")
                    .renderingMode(.template)
                    .foregroundColor(item.rarity.getColor())
                Text("\(item.type.getEmoji()) \(item.name)")
            }
        }
    }
}

#Preview {
    LootRow(item: MockData.lootItemsMock[0])
}
